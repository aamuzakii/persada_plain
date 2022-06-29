
class AuthenticationsController < ApplicationController
  
  require 'json_web_token'

  def post_otp
    token = JsonWebToken.encode(user_id: "this-is-use-id")
    time = Time.now + 6.months.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: "my username" }, status: :ok
  end

  def request_otp
    
    otp_code = ''
    [1,2,3,4].each do |single|
      otp_code += rand(9).to_s
    end
    otp = Otp.new({ phone_number: '62' + params[:phone], otp_code: otp_code })
    if otp.save
      uri = "http://localhost:9500/otp?number=#{params[:phone]}&otp=#{otp.otp_code}"
      response = HTTParty.get(uri)
    else
      message = 'failed to send OTP'
    end
    render json: { message: 'OTP sent' }, status: :ok
  end

  def google_login
    customer = Customer.find_by(email: params['profileObj']['email'])
    if customer.present?
      puts "email already exist"
      give_access(customer)
    else
      puts "new email"
      customer = Customer.new({
        name: params['profileObj']['name'],
        email: params['profileObj']['email'],
        access_type: 'buyer',
        pofile_photo: params['profileObj']['imageUrl'],
        google_id: params['profileObj']['googleId'],
      })
      customer.save
      puts "giving access.."
      give_access(customer)
    end

  end

  def password_login
    customer = Customer.find_by(email: params['email'])
    if customer.present?
      match = customer.password == params['password']
      if match
        give_access(customer)
      else
        render json: { status: 401, message: 'wrong password' }
      end
    else
      render json: { status: 404, message: 'wrong email' }
    end
  end
  

  private

  def generate_token(user_id)
    token = JWT.encode({user_id: user_id}, ENV['HMAC_SECRET'], 'HS256')
  end

  def give_access(customer)
    token = generate_token(customer.id.to_s)
    exp = Time.now + 6.months.to_i
    render json: { token: token, exp: exp.strftime("%m-%d-%Y %H:%M"), username: customer.name }, status: :ok
  end

end
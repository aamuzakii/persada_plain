
class AuthenticationsController < ApplicationController
  
  require 'json_web_token'

  def post_otp
    token = JsonWebToken.encode(user_id: "this-is-use-id")
    time = Time.now + 6.months.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: "my username" }, status: :ok
  end

  def request_otp
    
    if ['000','111','6283894588105'].include?(params['phone'])
      
      customer = Customer.find_by(phone: params['phone']) # harusnya find_or_create ga sih
      token = generate_token(customer.id.to_s)
      exp = Time.now + 6.months.to_i
      render json: { token: token, exp: exp.strftime("%m-%d-%Y %H:%M"), username: customer.name }, status: :ok
    else
      # send message via Vonage
    end
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
    token = JsonWebToken.encode(user_id: user_id)
  end

  def give_access(customer)
    token = generate_token(customer.id.to_s)
    exp = Time.now + 6.months.to_i
    render json: { token: token, exp: exp.strftime("%m-%d-%Y %H:%M"), username: customer.name }, status: :ok
  end

end
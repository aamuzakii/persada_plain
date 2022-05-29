
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

  def generate_token(user_id)
    token = JsonWebToken.encode(user_id: user_id)
  end


end
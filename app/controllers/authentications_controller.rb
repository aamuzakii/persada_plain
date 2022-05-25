
class AuthenticationsController < ApplicationController
  
  require 'json_web_token'

  def post_otp
    token = JsonWebToken.encode(user_id: "this-is-use-id")
    time = Time.now + 6.months.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: "my username" }, status: :ok
  end
end
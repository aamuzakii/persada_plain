class ApplicationController < ActionController::Base
  require 'json_web_token'

  skip_before_action :verify_authenticity_token

  def authorize_request
    token = request.headers["Authorization"]
    begin
      decoded = JWT.decode(token, ENV['HMAC_SECRET'], true, { algorithm: 'HS256' })
      @current_user = Customer.find(decoded.first['user_id'])
    rescue
    end
  end
  
end

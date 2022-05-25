class ApplicationController < ActionController::Base
  require 'json_web_token'

  skip_before_action :verify_authenticity_token
  after_action :cors_set_access_control_headers

  def authorize_request
    
    
    
    token = request.cookies['token']
    begin
      @decoded = JsonWebToken.decode(token)
      binding.pry
      # @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://localhost:8000'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  
end

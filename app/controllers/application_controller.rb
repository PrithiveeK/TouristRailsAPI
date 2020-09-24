require 'json_web_token'

class ApplicationController < ActionController::API

    def not_found
        render json: { code: 404, msg: 'request not found' }
    end

    def authorize_request
        token = request.headers['token']
        begin
          @decoded = JsonWebToken.decode(token)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
        end
    end

    def create_token(payload)
        JsonWebToken.encode(payload)
    end

end

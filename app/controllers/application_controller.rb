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

    def master_data_search_view_access
      if @current_user.role_id == 1
        return
      end
      access = UserAccessMapping.find_by user_id: @current_user.id, access_id: 15
      if access == nil
        render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
      end 
    end

    def master_data_add_edit_access
      if @current_user.role_id == 1
        return
      end
      access = UserAccessMapping.find_by user_id: @current_user.id, access_id: 16
      if access == nil
        render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
      end 
    end

    def super_company_search_view_access
      if @current_user.role_id == 1
        return
      end
      access = UserAccessMapping.find_by user_id: @current_user.id, access_id: 9
      if access == nil
        render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
      end
    end

    def super_company_add_edit_access
      if @current_user.role_id == 1
        return
      end
      access = UserAccessMapping.find_by user_id: @current_user.id, access_id: 10
      if access == nil
        render json: { code: 401, msg: 'Authentication failed' }, status: :unauthorized
      end
    end

end

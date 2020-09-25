class Api::AuthenticationController < ApplicationController
    before_action :authorize_request, except: [:login]

    def login
        @user = User.find_by(email: login_user[:email])
        if @user&.authenticate(login_user[:password])
            @token = create_token({user_id: @user.id})
            render :login
        else
            render json: {code: 401, msg: "Invalid Email OR Password"}
        end
    end

    def get_access
        access = []
        case @current_user.role_id
        when 1
            access = ['sc', 'md', 'aga', 'bga']
        when 2
            access = ['aga']
        when 3
            access = ['bga', 'q']
        when 4
            access = ['aga', 'bga', 'q']
        end
        render json: {code: 200, data: access}
    end

    private

    def login_user
        params.require(:authentication).permit(:email, :password)
    end


end
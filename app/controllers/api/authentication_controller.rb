class Api::AuthenticationController < ApplicationController
    # before_action :authorize, except: [:login]

    def login
        @user = User.find_by(email: login_user[:email])
        if @user&.authenticate(login_user[:password])
            @token = create_token({user_id: @user.id})
            puts @token
            render :login
        else
            render json: {code: 401, msg: "Invalid Email OR Password"}
        end
    end

    private

    def login_user
        params.require(:authentication).permit(:email, :password)
    end


end
class Api::UsersController < ApplicationController
    # before_action :authorize_request

    def create
        create_user[:password] = '12345678'
        create_user[:password_confirmation] = '12345678'
        @user = User.create(create_user)
        if @user.email
            @user.save(:validate => false)
            render :created, status: :created
        else
            render json: {code: 400, msg: "Account Already Exists"}
        end
    end

    def index
        @users = User.order(:id)
        render json: {code: 200, data: @users}
    end

    private

    def create_user
        params.require(:users).permit(
            :first_name,
            :sur_name,
            :middle_name,
            :last_name, 
            :designation, 
            :local_name,
            :email, 
            :phone,
            :date_of_birth,
            :date_of_joining,
            :anniversary_date,
            :company_id,
            :is_preffered_contact,
            :role_id,
            :department_id,
            :title_id,
            :service_type_id,
            :code
        )
    end

    def create_contact
        params.require(:contacts).permit(
            :country_id,
            :city_id,
            :zipcode,
            :phone_no,
            :email,
            :fax,
            :telephone_no,
            :address_line_1,
            :address_line_2,
            :street,
            :skype_id,
            :website
        )
    end
end

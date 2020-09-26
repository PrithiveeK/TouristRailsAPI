class Api::StaffController < ApplicationController
    before_action :authorize_request
    before_action :super_company_search_view_access ,only: [:index, :show]
    before_action :super_company_add_edit_access, only: [:create, :update, :destroy]

    def index
        @staffs = User.left_outer_joins(:company).select(
            "users.*, companies.name as company_name"
        ).where("companies.id = ? OR companies.parent_id = ?", 
            params[:company_id].to_i, params[:company_id].to_i
        )
        render json: {code: 200, data: @staffs}
    end

    def create
        contact = Contact.new(contact_params)
        if contact.valid?
            contact.save()
        else
            render json: {code: 500, msg: 'cannot create contact'}
            return
        end
        newStaff = User.new(basic_params)
        newStaff.code = "STAFF#{User.last.id}"
        newStaff.contact = contact
        newStaff.email = contact.email
        newStaff.password = '12345678'
        newStaff.password_confirmation = '12345678'
        if !newStaff.save(:validate => false)
            render json: {code: 500, msg: 'cannot create staff'}
            return
        end

        params[:staff][:permissions].each do |key, value|
            access = Access.find_by access_type: key, name: "SEARCH/VIEW"
            UserAccessMapping.create(user_id: newStaff.id, access_id: access.id) if value[0]
            UserAccessMapping.create(user_id: newStaff.id, access_id: access.id + 1) if value[1]
        end

        staff = User.left_outer_joins(:company).select(
            "users.*, companies.name as company_name"
        ).find(newStaff.id)

        render json: {code: 201, data: staff, msg: "created successfully"}
    end

    private

    def basic_params
        params.require(:staff).require(:basic).permit(
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

    def contact_params
        params.require(:staff).require(:advanced).permit(
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

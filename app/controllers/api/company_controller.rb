class Api::CompanyController < ApplicationController
    before_action :authorize_request
    before_action :super_company_search_view_access ,only: [:index, :show]
    before_action :super_company_add_edit_access, only: [:create, :update, :destroy]

    def index
        @companies = Company.left_outer_joins(
            :contact,
            contact: [:country, :city]
        ).select("companies.*, contacts.country_id, contacts.city_id, contacts.country_id,
            contacts.street, contacts.zipcode, contacts.website, contacts.phone_no, 
            contacts.telephone_no, contacts.fax, contacts.email, contacts.skype_id,
            countries.name AS country_name, cities.name AS city_name"
        ).where(status: 'ACTIVE')
        render json: {code: 200, data: @companies}
    end
    
    def create
        render json: {code: 201, msg: 'Created Company Successfully'}
    end
    
    def update
        @company = Company.find_by id: params[:id]
        if @company
            update_params.each do |key, value|
                if @company.has_attribute? key
                    @company.update_attribute(key, value)
                end
                if @company.contact.has_attribute? key
                    @company.contact.update_attribute(key, value)
                end
            end
            company = Company.left_outer_joins(
                :contact,
                contact: [:country, :city]
            ).select("companies.*, contacts.country_id, contacts.city_id, contacts.country_id,
                contacts.street, contacts.zipcode, contacts.website, contacts.phone_no, 
                contacts.telephone_no, contacts.fax, contacts.email, contacts.skype_id,
                countries.name AS country_name, cities.name AS city_name"
            ).find(@company.id)
            render json: {code: 201, data: company, msg: 'Updated Successfully!'}
        else
            render json: {code: 400, msg: 'Couldn\'t update. Please, Try again!'}
        end
    end
    
    def show
        company = Company.left_outer_joins(
            :contact,
            contact: [:country, :city]
        ).select("companies.*, contacts.country_id, contacts.city_id, contacts.country_id,
            contacts.street, contacts.zipcode, contacts.website, contacts.phone_no, 
            contacts.telephone_no, contacts.fax, contacts.email, contacts.skype_id,
            countries.name AS country_name, cities.name AS city_name"
        ).find(params[:id])
        render json: {code: 200, data: company}
    end 

    def destroy
        destroyCompany = Company.find_by id: params[:id]
        if destroyCompany
            destroyCompany.update(status: 'DELETED')
        end
        render json: {code: 200, msg: 'Deleted Successfully'}
    end

    private

    def update_params
        params.require(:company).permit(
            :name,
            :date_of_establishment,
            :status,
            :code,
            :country_id,
            :city_id,
            :street,
            :zipcode,
            :website,
            :phone_no,
            :telephone_no,
            :fax,
            :email,
            :skype_id
        )
    end

end

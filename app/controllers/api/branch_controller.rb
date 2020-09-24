class Api::BranchController < ApplicationController

    def index 
        @companies = Company.left_outer_joins(
            :contact,
            contact: [:country, :city]
        ).select("companies.*, contacts.country_id, contacts.city_id, contacts.country_id,
            contacts.street, contacts.zipcode, contacts.website, contacts.phone_no, 
            contacts.telephone_no, contacts.fax, contacts.email, contacts.skype_id,
            countries.name AS country_name, cities.name AS city_name"
        ).where(status: 'ACTIVE', parent_id: params[:company_id])
        render json: {code: 200, data: @companies}
    end

    def create
        @companyContact = Contact.new(contact_params)
        @companyContact.save(:validate => false)
        @company = Company.new(company_params)
        @company.contact = @companyContact
        @company.parent_id = params[:company_id]
        @company.is_preferred = false
        if @company.save(:validate => false)
            company = Company.left_outer_joins(
                :contact,
                contact: [:country, :city]
            ).select("companies.*, contacts.country_id, contacts.city_id, contacts.country_id,
                contacts.street, contacts.zipcode, contacts.website, contacts.phone_no, 
                contacts.telephone_no, contacts.fax, contacts.email, contacts.skype_id,
                countries.name AS country_name, cities.name AS city_name"
            ).find(@company.id)
            render json: {code: 201, data: company, msg: 'Created Successfully!'}
        else
            render json: {code: 400, msg: 'Couldn\'t create. Please, Try again!'}
        end    
    end

    private

    def company_params
        params.require(:branch).permit(
            :name,
            :date_of_establishment,
            :status,
            :company_type_id,
            :code
        )
    end
    
    def contact_params
        params.require(:branch).permit(
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

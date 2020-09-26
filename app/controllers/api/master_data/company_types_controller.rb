class Api::MasterData::CompanyTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "company_types.status = 'ACTIVE'"
        filter += " and company_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and company_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        company_types = CompanyType.where(filter)

        render json: {code: 200, data: company_types, msg: 'Fetched Successfully'}
    end

    def create
        @newCompany = CompanyType.create(company_params)
        if @newCompany.valid?
            @newCompany.save
            render json: {code: 201, data: @newCompany, msg: 'Added CompanyType Successfully'}
        else
            render json: {code: 400, msg: 'CompanyType Already Exists'}
        end
    end

    def update
        begin
            updateCompany = CompanyType.update(params[:id], company_params)
            if updateCompany.valid?
                updateCompany.save
                render json: {code: 200, data: updateCompany, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateCompany, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        company = CompanyType.find_by id: params[:id]
        if company
            company.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def company_params
        params.require(:company_types).permit(:name, :description)
    end
end

class Api::MasterData::CompanyTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @companys = CompanyType.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @companys}
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

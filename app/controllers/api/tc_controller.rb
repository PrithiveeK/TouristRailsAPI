class Api::TcController < ApplicationController
    before_action :authorize_request
    before_action :super_company_search_view_access ,only: [:index, :show]
    before_action :super_company_add_edit_access, only: [:create, :update, :destroy]

    def index
        @tcs = CompanyTc.left_outer_joins(:document_type, :tc).select(
            "company_tcs.*, document_types.name as document_type_name,
            terms_and_conditions.terms as terms"
        ).where(company_id: params[:company_id])
        render json: {code: 200, data: @tcs}
    end

    def create
        @newTC =  CompanyTc.new(create_params)
        @newTC.company_id = params[:company_id]
        if @newTC.valid?
            @newTC.save
            tc = CompanyTc.left_outer_joins(:document_type, :tc).select(
                "company_tcs.*, document_types.name as document_type_name,
                terms_and_conditions.terms as terms"
            ).find(@newTC.id)
            render json: {code: 201, data: tc, msg: 'Created successfully!'}
        else
            render json: {code: 400, msg: 'Invalid Data. Please Try again'}
        end
    end

    private 

    def create_params
        params.require(:tc).permit(:order_id, :subject, :tc_id, :document_type_id)
    end
end

class Api::MasterData::TermsAndConditionsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "terms_and_conditions.status = 'ACTIVE'"
        filter += " and terms_and_conditions.id = #{params[:id].to_i}" if params[:id]
        filter += " and terms_and_conditions.name LIKE = '%#{params[:name]}%'" if params[:name]

        terms_and_conditions = TermsAndCondition.joins(
            'LEFT OUTER JOIN markets AS from_market ON terms_and_conditions.from_market_id = from_market.id',
            'LEFT OUTER JOIN markets AS to_market ON terms_and_conditions.to_market_id = to_market.id'
        ).select(
            "terms_and_conditions.*, from_market.name as from_market_name, to_market.name as to_market_name"
        ).where(filter)

        render json: {code: 200, data: terms_and_conditions, msg: 'Fetched Successfully'}
    end
    
    def create
        @newTC = TermsAndCondition.create(tc_params)
        if @newTC.valid?
            @newTC.save
            render :created
        else
            render json: {code: 400, msg: 'Invalid Terms and Conditions'}
        end
    end
    
    def update
        begin
            @updateTC = TermsAndCondition.update(params[:id], tc_params)
            if @updateTC.valid?
                @updateTC.save
                render :updated
            else
                render json: {code: 400, msg: 'Invalid Terms and Conditions'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end
    
    def destroy
        tc = TermsAndCondition.find_by id: params[:id]
        if tc
            tc.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def tc_params
        params.require(:terms_and_conditions).permit(:terms, :from_market_id, :to_market_id)
    end
end

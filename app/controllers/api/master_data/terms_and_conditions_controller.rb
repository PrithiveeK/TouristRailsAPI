class Api::MasterData::TermsAndConditionsController < ApplicationController
    before_action :authorize_request

    def index
       @tcs = TermsAndCondition.where(status: 'ACTIVE').order(:id)
       render :all_tcs 
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

class Api::MasterData::ChargeTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @cts = ChargeType.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @cts}
    end

    def create
        @newCT = ChargeType.create(ct_params)
        if @newCT.valid?
            @newCT.save
            render json: {code: 201, data: @newCT, msg: 'Added ChargeType Successfully'}
        else
            render json: {code: 400, msg: 'ChargeType Already Exists'}
        end
    end

    def update
        begin
            updateCT = ChargeType.update(params[:id], ct_params)
            if updateCT.valid?
                updateCT.save
                render json: {code: 200, data: updateCT, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateCT, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        ct = ChargeType.find_by id: params[:id]
        if ct
            ct.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def ct_params
        params.require(:charge_types).permit(:name, :description)
    end
end

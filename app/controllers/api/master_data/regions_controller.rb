class Api::MasterData::RegionsController < ApplicationController
    # before_action :authorize_request

    def index
        @regions = Region.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @regions}
    end

    def create
        @newRegion = Region.create(region_params)
        if @newRegion.valid?
            @newRegion.save
            render json: {code: 201, data: @newRegion, msg: 'Added Region Successfully'}
        else
            render json: {code: 400, msg: 'Region Already Exists'}
        end
    end

    def update
        begin
            updateRegion = Region.update(params[:id], region_params)
            if updateRegion.valid?
                updateRegion.save
                render json: {code: 200, data: updateRegion, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateRegion, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        region = Region.find_by id: params[:id]
        if region
            region.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def region_params
        params.require(:regions).permit(:name, :description)
    end
end

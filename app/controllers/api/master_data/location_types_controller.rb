class Api::MasterData::LocationTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "location_types.status = 'ACTIVE'"
        filter += " and location_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and location_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        location_types = LocationType.where(filter)

        render json: {code: 200, data: location_types, msg: 'Fetched Successfully'}
    end

    def create
        @newLT = LocationType.create(lt_params)
        if @newLT.valid?
            @newLT.save
            render json: {code: 201, data: @newLT, msg: 'Added LocationType Successfully'}
        else
            render json: {code: 400, msg: 'LocationType Already Exists'}
        end
    end

    def update
        begin
            updateLT = LocationType.update(params[:id], lt_params)
            if updateLT.valid?
                updateLT.save
                render json: {code: 200, data: updateLT, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateLT, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        lt = LocationType.find_by id: params[:id]
        if lt
            lt.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def lt_params
        params.require(:location_types).permit(:name, :description)
    end
end

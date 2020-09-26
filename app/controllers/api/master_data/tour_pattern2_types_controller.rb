class Api::MasterData::TourPattern2TypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "tour_pattern2_types.status = 'ACTIVE'"
        filter += " and tour_pattern2_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and tour_pattern2_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        tour_pattern2_types = TourPattern2Type.where(filter)

        render json: {code: 200, data: tour_pattern2_types, msg: 'Fetched Successfully'}
    end

    def create
        @newTourPattern2 = TourPattern2Type.create(tour_pattern2_params)
        if @newTourPattern2.valid?
            @newTourPattern2.save
            render json: {code: 201, data: @newTourPattern2, msg: 'Added TourPattern2Type Successfully'}
        else
            render json: {code: 400, msg: 'TourPattern2Type Already Exists'}
        end
    end

    def update
        begin
            updateTourPattern2 = TourPattern2Type.update(params[:id], tour_pattern2_params)
            if updateTourPattern2.valid?
                updateTourPattern2.save
                render json: {code: 200, data: updateTourPattern2, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateTourPattern2, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        tourPattern2 = TourPattern2Type.find_by id: params[:id]
        if tourPattern2
            tourPattern2.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def tour_pattern2_params
        params.require(:tour_pattern2_types).permit(:name, :description)
    end
end

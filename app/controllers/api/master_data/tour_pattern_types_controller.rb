class Api::MasterData::TourPatternTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "tour_pattern_types.status = 'ACTIVE'"
        filter += " and tour_pattern_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and tour_pattern_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        tour_pattern_types = TourPatternType.where(filter)

        render json: {code: 200, data: tour_pattern_types, msg: 'Fetched Successfully'}
    end

    def create
        @newTourPattern = TourPatternType.create(tour_pattern_params)
        if @newTourPattern.valid?
            @newTourPattern.save
            render json: {code: 201, data: @newTourPattern, msg: 'Added TourPatternType Successfully'}
        else
            render json: {code: 400, msg: 'TourPatternType Already Exists'}
        end
    end

    def update
        begin
            updateTourPattern = TourPatternType.update(params[:id], tour_pattern_params)
            if updateTourPattern.valid?
                updateTourPattern.save
                render json: {code: 200, data: updateTourPattern, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateTourPattern, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        tourPattern = TourPatternType.find_by id: params[:id]
        if tourPattern
            tourPattern.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def tour_pattern_params
        params.require(:tour_pattern_types).permit(:name, :description)
    end
end

class Api::MasterData::TourPatternTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @tourPatterns = TourPatternType.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @tourPatterns}
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

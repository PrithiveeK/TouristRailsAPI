class Api::MasterData::TourPattern2TypesController < ApplicationController
    # before_action :authorize_request

    def index
        @tourPattern2s = TourPattern2Type.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @tourPattern2s = @tourPattern2s.where(id: params[:id].to_i)
        end
        if params[:name]
            @tourPattern2s = @tourPattern2s.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @tourPattern2s}
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

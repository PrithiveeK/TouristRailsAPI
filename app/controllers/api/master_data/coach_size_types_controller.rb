class Api::MasterData::CoachSizeTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @coachSizes = CoachSizeType.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @coachSizes}
    end

    def create
        @newCoachSize = CoachSizeType.create(coach_size_params)
        if @newCoachSize.valid?
            @newCoachSize.save
            render json: {code: 201, data: @newCoachSize, msg: 'Added CoachSizeType Successfully'}
        else
            render json: {code: 400, msg: 'CoachSizeType Already Exists'}
        end
    end

    def update
        begin
            updateCoachSize = CoachSizeType.update(params[:id], coach_size_params)
            if updateCoachSize.valid?
                updateCoachSize.save
                render json: {code: 200, data: updateCoachSize, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateCoachSize, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        coachSize = CoachSizeType.find_by id: params[:id]
        if coachSize
            coachSize.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def coach_size_params
        params.require(:coach_size_types).permit(:coach_size, :description)
    end
end

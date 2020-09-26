class Api::MasterData::CoachSizeTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "coach_size_types.status = 'ACTIVE'"
        filter += " and coach_size_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and coach_size_types.coach_size = '#{params[:name]}'" if params[:name]

        coach_size_types = CoachSizeType.where(filter)

        render json: {code: 200, data: coach_size_types, msg: 'Fetched Successfully'}
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

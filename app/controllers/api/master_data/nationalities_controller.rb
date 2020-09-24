class Api::MasterData::NationalitiesController < ApplicationController
    # before_action :authorize_request

    def index
        @nationalities = Nationality.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @nationalities}
    end

    def create
        @newNationality = Nationality.create(nationality_params)
        if @newNationality.valid?
            @newNationality.save
            render json: {code: 201, data: @newNationality, msg: 'Added Nationality Successfully'}
        else
            render json: {code: 400, msg: 'Nationality Already Exists'}
        end
    end

    def update
        begin
            updateNationality = Nationality.update(params[:id], nationality_params)
            if updateNationality.valid?
                updateNationality.save
                render json: {code: 200, data: updateNationality, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateNationality, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        nationality = Nationality.find_by id: params[:id]
        if nationality
            nationality.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def nationality_params
        params.require(:nationalities).permit(:name, :description)
    end
end

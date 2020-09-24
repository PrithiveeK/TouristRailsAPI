class Api::MasterData::FacilitiesController < ApplicationController
    before_action :authorize_request

    def index
        @facilities = Facility.where(status: 'ACTIVE').order(:id)
        render :all_facilities
    end

    def create
        @newFacility = Facility.create(facility_params)
        if @newFacility.valid?
            @newFacility.save
            render :created
        else
            render json: {code: 400, msg: 'Facility Already Exists'}
        end
    end

    def update
        begin
            @updateFacility = Facility.update(params[:id], facility_params)
            if @updateFacility.valid?
                @updateFacility.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        facility = Facility.find_by id: params[:id]
        if facility
            facility.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def facility_params
        params.require(:facilities).permit(:name, :description, :service_type_id)
    end
end

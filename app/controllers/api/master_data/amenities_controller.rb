class Api::MasterData::AmenitiesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "amenities.status = 'ACTIVE'"
        filter += " and amenities.id = #{params[:id].to_i}" if params[:id]
        filter += " and amenities.name LIKE = '%#{params[:name]}%'" if params[:name]

        amenities = Amenity.left_outer_join(:service_type).select(
            "amenities.*, service_types.name as service_type_name"
        ).where(filter)

        render json: {code: 200, data: amenities, msg: 'Fetched Successfully'}
    end

    def create
        @newAmenity = Amenity.create(amenity_params)
        if @newAmenity.valid?
            @newAmenity.save
            render :created
        else
            render json: {code: 400, msg: 'Amenity Already Exists'}
        end
    end

    def update
        begin
            @updateAmenity = Amenity.update(params[:id], amenity_params)
            if @updateAmenity.valid?
                @updateAmenity.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        amenity = Amenity.find_by id: params[:id]
        if amenity
            amenity.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def amenity_params
        params.require(:amenities).permit(:name, :description, :service_type_id)
    end
end

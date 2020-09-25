class Api::MasterData::AmenitiesController < ApplicationController
    before_action :authorize_request

    def index
        @amenities = Amenity.where(status: 'ACTIVE')
        if params[:id]
            @amenities = @amenities.where(id: params[:id].to_i)
        end
        if params[:name]
            @amenities = @amenities.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render :all_amenities
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

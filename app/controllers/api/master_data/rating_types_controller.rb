class Api::MasterData::RatingTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "rating_types.status = 'ACTIVE'"
        filter += " and rating_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and rating_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        rating_types = RatingType.where(filter)

        render json: {code: 200, data: rating_types, msg: 'Fetched Successfully'}
        @ratings = RatingType.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @ratings = @ratings.where(id: params[:id].to_i)
        end
        if params[:name]
            @ratings = @ratings.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @ratings}
    end

    def create
        @newRating = RatingType.create(rating_params)
        if @newRating.valid?
            @newRating.save
            render json: {code: 201, data: @newRating, msg: 'Added RatingType Successfully'}
        else
            render json: {code: 400, msg: 'RatingType Already Exists'}
        end
    end

    def update
        begin
            updateRating = RatingType.update(params[:id], rating_params)
            if updateRating.valid?
                updateRating.save
                render json: {code: 200, data: updateRating, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateRating, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        rating = RatingType.find_by id: params[:id]
        if rating
            rating.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def rating_params
        params.require(:rating_types).permit(:name, :description)
    end
end

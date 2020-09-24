class Api::MasterData::CategoryTypesController < ApplicationController
    before_action :authorize_request

    def index
        @categories = CategoryType.where(status: 'ACTIVE').order(:id)
        render :all_categories
    end

    def create
        @newCategoryType = CategoryType.create(categorytype_params)
        if @newCategoryType.valid?
            @newCategoryType.save
            render :created
        else
            render json: {code: 400, msg: 'CategoryType Already Exists'}
        end
    end

    def update
        begin
            @updateCategoryType = CategoryType.update(params[:id], categorytype_params)
            if @updateCategoryType.valid?
                @updateCategoryType.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        categorytype = CategoryType.find_by id: params[:id]
        if categorytype
            categorytype.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def categorytype_params
        params.require(:category_types).permit(:name, :description, :service_type_id)
    end
end

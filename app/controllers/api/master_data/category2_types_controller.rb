class Api::MasterData::Category2TypesController < ApplicationController
    before_action :authorize_request

    def index
        @categories = Category2Type.where(status: 'ACTIVE')
        if params[:id]
            @categories = @categories.where(id: params[:id].to_i)
        end
        if params[:name]
            @categories = @categories.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render :all_categories
    end

    def create
        @newCategoryType = Category2Type.create(category2type_params)
        if @newCategoryType.valid?
            @newCategoryType.save
            render :created
        else
            render json: {code: 400, msg: 'Category type Already Exists'}
        end
    end

    def update
        begin
            @updateCategoryType = Category2Type.update(params[:id], category2type_params)
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
        categorytype = Category2Type.find_by id: params[:id]
        if categorytype
            categorytype.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def category2type_params
        params.require(:category2_types).permit(:name, :description, :service_type_id)
    end
end

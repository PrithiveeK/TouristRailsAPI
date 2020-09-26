class Api::MasterData::Category2TypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "category2_types.status = 'ACTIVE'"
        filter += " and category2_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and category2_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        category2_types = Category2Type.left_outer_join(:service_type).select(
            "category2_types.*, service_types.name as service_type_name"
        ).where(filter)

        render json: {code: 200, data: category2_types, msg: 'Fetched Successfully'}
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

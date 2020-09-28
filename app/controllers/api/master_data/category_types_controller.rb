class Api::MasterData::CategoryTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "category_types.status = 'ACTIVE'"
        filter += " and category_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and category_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        category_types = CategoryType.left_outer_joins(:service_type).select(
            "category_types.*, service_types.name as service_type_name"
        ).where(filter)

        render json: {code: 200, data: category_types, msg: 'Fetched Successfully'}
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

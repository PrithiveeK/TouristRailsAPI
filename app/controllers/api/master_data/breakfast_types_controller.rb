class Api::MasterData::BreakfastTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "breakfast_types.status = 'ACTIVE'"
        filter += " and breakfast_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and breakfast_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        breakfast_types = BreakfastType.where(filter)
        render json: {code: 200, data: breakfast_types, msg: 'Fetched Successfully'}
    end

    def create
        @newBreakfast = BreakfastType.create(breakfast_params)
        if @newBreakfast.valid?
            @newBreakfast.save
            render json: {code: 201, data: @newBreakfast, msg: 'Added BreakfastType Successfully'}
        else
            render json: {code: 400, msg: 'BreakfastType Already Exists'}
        end
    end

    def update
        begin
            updateBreakfast = BreakfastType.update(params[:id], breakfast_params)
            if updateBreakfast.valid?
                updateBreakfast.save
                render json: {code: 200, data: updateBreakfast, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateBreakfast, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        breakfast = BreakfastType.find_by id: params[:id]
        if breakfast
            breakfast.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def breakfast_params
        params.require(:breakfast_types).permit(:name, :description)
    end
end

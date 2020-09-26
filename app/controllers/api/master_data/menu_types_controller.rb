class Api::MasterData::MenuTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "menu_types.status = 'ACTIVE'"
        filter += " and menu_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and menu_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        menu_types = MenuType.where(filter)

        render json: {code: 200, data: menu_types, msg: 'Fetched Successfully'}
    end

    def create
        @newMenu = MenuType.create(menu_params)
        if @newMenu.valid?
            @newMenu.save
            render json: {code: 201, data: @newMenu, msg: 'Added MenuType Successfully'}
        else
            render json: {code: 400, msg: 'MenuType Already Exists'}
        end
    end

    def update
        begin
            updateMenu = MenuType.update(params[:id], menu_params)
            if updateMenu.valid?
                updateMenu.save
                render json: {code: 200, data: updateMenu, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateMenu, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        menu = MenuType.find_by id: params[:id]
        if menu
            menu.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def menu_params
        params.require(:menu_types).permit(:name, :description)
    end
end

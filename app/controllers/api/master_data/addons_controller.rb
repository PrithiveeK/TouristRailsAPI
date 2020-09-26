class Api::MasterData::AddonsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "addons.status = 'ACTIVE'"
        filter += " and addons.id = #{params[:id].to_i}" if params[:id]
        filter += " and addons.name LIKE = '%#{params[:name]}%'" if params[:name]

        addons = Addon.left_outer_join(:service_type).select(
            "addons.*, service_types.name as service_type_name"
        ).where(filter)

        render json: {code: 200, data: addons, msg: 'Fetched Successfully'}
    end

    def create
        @newAddon = Addon.create(addon_params)
        if @newAddon.valid?
            @newAddon.save
            render :created
        else
            render json: {code: 400, msg: 'Addon Already Exists'}
        end
    end

    def update
        begin
            @updateAddon = Addon.update(params[:id], addon_params)
            if @updateAddon.valid?
                @updateAddon.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        addon = Addon.find_by id: params[:id]
        if addon
            addon.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def addon_params
        params.require(:addons).permit(:name, :service_type_id)
    end
end

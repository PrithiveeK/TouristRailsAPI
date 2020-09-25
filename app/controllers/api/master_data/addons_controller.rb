class Api::MasterData::AddonsController < ApplicationController
    before_action :authorize_request

    def index
        @addons = Addon.where(status: 'ACTIVE')
        if params[:id]
            @addons = @addons.where(id: params[:id].to_i)
        end
        if params[:name]
            @addons = @addons.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render :all_addons
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

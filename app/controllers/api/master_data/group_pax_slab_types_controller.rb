class Api::MasterData::GroupPaxSlabTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "group_pax_slab_types.status = 'ACTIVE'"
        filter += " and group_pax_slab_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and group_pax_slab_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        group_pax_slab_types = GroupPaxSlab.where(filter)

        render json: {code: 200, data: group_pax_slab_types, msg: 'Fetched Successfully'}
    end
    
    def create
        @newGPS = GroupPaxSlabType.create(gps_params)
        if @newGPS.valid?
            @newGPS.save
            render json: {code: 201, data: @newGPS, msg: 'Created GroupPaxSlab Successfully'}
        else
            render json: {code: 400, msg: 'Invalid Terms and Conditions'}
        end
    end
    
    def update
        begin
            @updateGPS = GroupPaxSlabType.update(params[:id], gps_params)
            if @updateGPS.valid?
                @updateGPS.save
                render json: {code: 200, data: @updateGPS, msg: 'Updated Successfully'}
            else
                render json: {code: 400, msg: 'Invalid Terms and Conditions'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end
    
    def destroy
        gps = GroupPaxSlabType.find_by id: params[:id]
        if gps
            gps.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def gps_params
        params.require(:group_pax_slab_types).permit(:pax_slab, :foc, :sgl, :half_twin, :description)
    end
end

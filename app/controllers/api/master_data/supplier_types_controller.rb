class Api::MasterData::SupplierTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "supplier_types.status = 'ACTIVE'"
        filter += " and supplier_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and supplier_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        supplier_types = SupplierType.where(filter)

        render json: {code: 200, data: supplier_types, msg: 'Fetched Successfully'}
    end

    def create
        @newST = SupplierType.create(st_params)
        if @newST.valid?
            @newST.save
            render json: {code: 201, data: @newST, msg: 'Added SupplierType Successfully'}
        else
            render json: {code: 400, msg: 'SupplierType Already Exists'}
        end
    end

    def update
        begin
            updateST = SupplierType.update(params[:id], st_params)
            if updateST.valid?
                updateST.save
                render json: {code: 200, data: updateST, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateST, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        st = SupplierType.find_by id: params[:id]
        if st
            st.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def st_params
        params.require(:supplier_types).permit(:name, :description)
    end
end

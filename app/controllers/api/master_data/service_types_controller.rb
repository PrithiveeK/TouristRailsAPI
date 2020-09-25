class Api::MasterData::ServiceTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @sts = ServiceType.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @sts = @sts.where(id: params[:id].to_i)
        end
        if params[:name]
            @sts = @sts.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @sts}
    end

    def create
        @newST = ServiceType.create(st_params)
        if @newST.valid?
            @newST.save
            render json: {code: 201, data: @newST, msg: 'Added ServiceType Successfully'}
        else
            render json: {code: 400, msg: 'ServiceType Already Exists'}
        end
    end

    def update
        begin
            updateST = ServiceType.update(params[:id], st_params)
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
        st = ServiceType.find_by id: params[:id]
        if st
            st.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def st_params
        params.require(:service_types).permit(:name, :description)
    end
end

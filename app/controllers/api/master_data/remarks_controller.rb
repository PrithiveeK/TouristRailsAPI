class Api::MasterData::RemarksController < ApplicationController
     before_action :authorize_request
     before_action :master_data_search_view_access ,only: [:index, :show]
     before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

     def index
        filter = "remarks.status = 'ACTIVE'"
        filter += " and remarks.id = #{params[:id].to_i}" if params[:id]
        filter += " and remarks.name LIKE = '%#{params[:name]}%'" if params[:name]

        remarks = Remark.where(filter)

        render json: {code: 200, data: remarks, msg: 'Fetched Successfully'}
    end

    def create
        @newRemark = Remark.create(remark_data)
        if @newRemark.valid?
            @newRemark.save
            render json: {code: 201, data: @newRemark, msg: 'Added Remark Successfully'}
        else
            render json: {code: 400, msg: 'Remark Already Exists'}
        end
    end

    def update
        begin
            updateRemark = Remark.update(params[:id], remark_data)
            if updateRemark.valid?
                updateRemark.save
                render json: {code: 200, data: updateRemark, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateRemark, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        remark = Remark.find_by id: params[:id]
        if remark
            remark.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def remark_data
        remark_params[:select_type] = nil if remark_params[:remark_type] == 'STATIC'
        return remark_params
    end

    def remark_params
        params.require(:remarks).permit(:name, :remark_type, :select_type)
    end
end

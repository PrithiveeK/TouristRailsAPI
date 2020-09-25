class Api::MasterData::Location2TypesController < ApplicationController
    # before_action :authorize_request

    def index
        @lts = Location2Type.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @lts = @lts.where(id: params[:id].to_i)
        end
        if params[:name]
            @lts = @lts.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @lts}
    end

    def create
        @newLT = Location2Type.create(lt_params)
        if @newLT.valid?
            @newLT.save
            render json: {code: 201, data: @newLT, msg: 'Added Location2Type Successfully'}
        else
            render json: {code: 400, msg: 'Location2Type Already Exists'}
        end
    end

    def update
        begin
            updateLT = Location2Type.update(params[:id], lt_params)
            if updateLT.valid?
                updateLT.save
                render json: {code: 200, data: updateLT, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateLT, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        lt = Location2Type.find_by id: params[:id]
        if lt
            lt.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def lt_params
        params.require(:location2_types).permit(:name, :description)
    end
end

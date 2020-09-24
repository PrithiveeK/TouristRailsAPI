class Api::MasterData::ClassTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @classtypes = ClassType.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @classtypes}
    end

    def create
        @newClassType = ClassType.create(classtype_params)
        if @newClassType.valid?
            @newClassType.save
            render json: {code: 201, data: @newClassType, msg: 'Added ClassType Successfully'}
        else
            render json: {code: 400, msg: 'ClassType Already Exists'}
        end
    end

    def update
        begin
            updateClassType = ClassType.update(params[:id], classtype_params)
            if updateClassType.valid?
                updateClassType.save
                render json: {code: 200, data: updateClassType, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateClassType, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        classtype = ClassType.find_by id: params[:id]
        if classtype
            classtype.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def classtype_params
        params.require(:class_types).permit(:name, :description)
    end
end

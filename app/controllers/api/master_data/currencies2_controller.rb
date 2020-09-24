class Api::MasterData::Currencies2Controller < ApplicationController
    # before_action :authorize_request

    def index
        @c2s = Currencies2.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @c2s}
    end

    def create
        @newC2 = Currencies2.create(c2_params)
        if @newC2.valid?
            @newC2.save
            render json: {code: 201, data: @newC2, msg: 'Added Currencies2 Successfully'}
        else
            render json: {code: 400, msg: 'Currencies2 Already Exists'}
        end
    end

    def update
        begin
            updateC2 = Currencies2.update(params[:id], c2_params)
            if updateC2.valid?
                updateC2.save
                render json: {code: 200, data: updateC2, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateC2, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        c2 = Currencies2.find_by id: params[:id]
        if c2
            c2.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def c2_params
        params.require(:currencies2).permit(:name, :description)
    end
end

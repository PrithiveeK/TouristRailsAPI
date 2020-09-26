class Api::MasterData::Currencies2Controller < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "currencies2s.status = 'ACTIVE'"
        filter += " and currencies2s.id = #{params[:id].to_i}" if params[:id]
        filter += " and currencies2s.name LIKE = '%#{params[:name]}%'" if params[:name]

        currencies2s = Currencies2.where(filter)

        render json: {code: 200, data: currencies2s, msg: 'Fetched Successfully'}
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

class Api::MasterData::PersonTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "person_types.status = 'ACTIVE'"
        filter += " and person_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and person_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        person_types = PersonType.where(filter)

        render json: {code: 200, data: person_types, msg: 'Fetched Successfully'}
    end

    def create
        @newPT = PersonType.create(pt_params)
        if @newPT.valid?
            @newPT.save
            render json: {code: 201, data: @newPT, msg: 'Added PersonType Successfully'}
        else
            render json: {code: 400, msg: 'PersonType Already Exists'}
        end
    end

    def update
        begin
            updatePT = PersonType.update(params[:id], pt_params)
            if updatePT.valid?
                updatePT.save
                render json: {code: 200, data: updatePT, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updatePT, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        pt = PersonType.find_by id: params[:id]
        if pt
            pt.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def pt_params
        params.require(:person_types).permit(:name, :description)
    end
end

class Api::MasterData::HotdateDifficultyController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "hotdate_difficulties.status = 'ACTIVE'"
        filter += " and hotdate_difficulties.id = #{params[:id].to_i}" if params[:id]
        filter += " and hotdate_difficulties.name LIKE = '%#{params[:name]}%'" if params[:name]

        hotdate_difficulties = HotdateDifficulty.where(filter)

        render json: {code: 200, data: hotdate_difficulties, msg: 'Fetched Successfully'}
    end

    def create
        @newHDD = HotdateDifficulty.create(hdd_params)
        if @newHDD.valid?
            @newHDD.save
            render json: {code: 201, data: @newHDD, msg: 'Added HotdateDifficulty Successfully'}
        else
            render json: {code: 400, msg: 'HotdateDifficulty Already Exists'}
        end
    end

    def update
        begin
            updateHDD = HotdateDifficulty.update(params[:id], hdd_params)
            if updateHDD.valid?
                updateHDD.save
                render json: {code: 200, data: updateHDD, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateHDD, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        hdd = HotdateDifficulty.find_by id: params[:id]
        if hdd
            hdd.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def hdd_params
        params.require(:hotdate_difficulty).permit(:name, :description)
    end
end

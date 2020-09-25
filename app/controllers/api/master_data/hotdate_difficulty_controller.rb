class Api::MasterData::HotdateDifficultyController < ApplicationController
    # before_action :authorize_request

    def index
        @hdds = HotdateDifficulty.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @hdds = @hdds.where(id: params[:id].to_i)
        end
        if params[:name]
            @hdds = @hdds.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @hdds}
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

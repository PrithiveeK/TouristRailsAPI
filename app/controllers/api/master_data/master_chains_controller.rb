class Api::MasterData::MasterChainsController < ApplicationController
    # before_action :authorize_request

    def index
        @masterchains = MasterChain.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @masterchains = @masterchains.where(id: params[:id].to_i)
        end
        if params[:name]
            @masterchains = @masterchains.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @masterchains}
    end

    def create
        @newMasterChain = MasterChain.create(masterchain_params)
        if @newMasterChain.valid?
            @newMasterChain.save
            render json: {code: 201, data: @newMasterChain, msg: 'Added MasterChain Successfully'}
        else
            render json: {code: 400, msg: 'MasterChain Already Exists'}
        end
    end

    def update
        begin
            updateMasterChain = MasterChain.update(params[:id], masterchain_params)
            if updateMasterChain.valid?
                updateMasterChain.save
                render json: {code: 200, data: updateMasterChain, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateMasterChain, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        masterchain = MasterChain.find_by id: params[:id]
        if masterchain
            masterchain.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def masterchain_params
        params.require(:master_chains).permit(:name, :description)
    end
end

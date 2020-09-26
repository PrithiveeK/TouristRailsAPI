class Api::MasterData::MasterChainsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "master_chains.status = 'ACTIVE'"
        filter += " and master_chains.id = #{params[:id].to_i}" if params[:id]
        filter += " and master_chains.name LIKE = '%#{params[:name]}%'" if params[:name]

        master_chains = MasterChain.where(filter)

        render json: {code: 200, data: master_chains, msg: 'Fetched Successfully'}
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

class Api::MasterData::ChainsController < ApplicationController
    before_action :authorize_request

    def index
       @chains = Chain.where(status: 'ACTIVE').order(:id)
       render :all_chains 
    end
    
    def create
        @newChain = Chain.create(chain_params)
        if @newChain.valid?
            @newChain.save
            render :created
        else
            render json: {code: 400, msg: 'Invalid Terms and Conditions'}
        end
    end
    
    def update
        begin
            @updateChain = Chain.update(params[:id], chain_params)
            if @updateChain.valid?
                @updateChain.save
                render :updated
            else
                render json: {code: 400, msg: 'Invalid Terms and Conditions'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end
    
    def destroy
        chain = Chain.find_by id: params[:id]
        if chain
            chain.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def chain_params
        params.require(:chains).permit(:name, :description, :master_chain_id, :service_type_id)
    end
end

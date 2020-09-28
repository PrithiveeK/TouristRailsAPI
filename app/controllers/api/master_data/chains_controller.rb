class Api::MasterData::ChainsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "chains.status = 'ACTIVE'"
        filter += " and chains.id = #{params[:id].to_i}" if params[:id]
        filter += " and chains.name LIKE = '%#{params[:name]}%'" if params[:name]

        chains = Chain.left_outer_joins(:service_type, :master_chain).select(
            "chains.*, service_types.name as service_type_name, master_chains.name as master_chain_name"
        ).where(filter)

        render json: {code: 200, data: chains, msg: 'Fetched Successfully'}
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

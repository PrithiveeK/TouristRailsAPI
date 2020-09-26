class Api::MasterData::MarketsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "markets.status = 'ACTIVE'"
        filter += " and markets.id = #{params[:id].to_i}" if params[:id]
        filter += " and markets.name LIKE = '%#{params[:name]}%'" if params[:name]

        markets = Market.where(filter)

        render json: {code: 200, data: markets, msg: 'Fetched Successfully'}
    end

    def create
        @newMarket = Market.create(market_params)
        if @newMarket.valid?
            @newMarket.save
            render json: {code: 201, data: @newMarket, msg: 'Added Market Successfully'}
        else
            render json: {code: 400, msg: 'Market Already Exists'}
        end
    end

    def update
        begin
            updateMarket = Market.update(params[:id], market_params)
            if updateMarket.valid?
                updateMarket.save
                render json: {code: 200, data: updateMarket, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateMarket, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        market = Market.find_by id: params[:id]
        if market
            market.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def market_params
        params.require(:markets).permit(:name, :description)
    end
end

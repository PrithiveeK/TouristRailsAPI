require 'csv'

class Api::MasterData::MarketsController < ApplicationController
    before_action :authorize_request

    def index
        @markets = Market.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @markets = @markets.where(id: params[:id].to_i)
        end
        if params[:name]
            @markets = @markets.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @markets}
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

    def insertFromCSV
        begin
            table = CSV.parse(File.read(fileName), headers: true)
            table.each do |row|
                newMarket = Market.create(name: rows["name"], description: row["description"])
                if newMarket.valid?
                    newMarket.save
                end
            end
            render json: {code: 201, msg: 'Successfully inserted data'}
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def market_params
        params.require(:markets).permit(:name, :description)
    end
end

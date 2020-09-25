class Api::MasterData::CurrenciesController < ApplicationController
    # before_action :authorize_request

    def index
        @currencies = Currency.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @currencies = @currencies.where(id: params[:id].to_i)
        end
        if params[:name]
            @currencies = @currencies.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @currencies}
    end

    def create
        @newCurrency = Currency.create(currency_params)
        if @newCurrency.valid?
            @newCurrency.save
            render json: {code: 201, data: @newCurrency, msg: 'Added Currency Successfully'}
        else
            render json: {code: 400, msg: 'Currency Already Exists'}
        end
    end

    def update
        begin
            updateCurrency = Currency.update(params[:id], currency_params)
            if updateCurrency.valid?
                updateCurrency.save
                render json: {code: 200, data: updateCurrency, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateCurrency, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        currency = Currency.find_by id: params[:id]
        if currency
            currency.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def currency_params
        params.require(:currencies).permit(:name, :description, :is_sales)
    end
end

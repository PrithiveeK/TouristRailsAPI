class Api::MasterData::CurrenciesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "currencies.status = 'ACTIVE'"
        filter += " and currencies.id = #{params[:id].to_i}" if params[:id]
        filter += " and currencies.name LIKE = '%#{params[:name]}%'" if params[:name]

        currencies = Currency.where(filter)

        render json: {code: 200, data: currencies, msg: 'Fetched Successfully'}

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

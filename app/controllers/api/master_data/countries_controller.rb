class Api::MasterData::CountriesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "countries.status = 'ACTIVE'"
        filter += " and countries.id = #{params[:id].to_i}" if params[:id]
        filter += " and countries.name LIKE = '%#{params[:name]}%'" if params[:name]

        countries = Country.left_outer_joins(:continent).select(
            "countries.*, continents.name as continent_name"
        ).where(filter)

        render json: {code: 200, data: countries, msg: 'Fetched Successfully'}
    end

    def create
        @newCountry = Country.create(country_params)
        if @newCountry.valid?
            @newCountry.save
            render :created
        else
            render json: {code: 400, msg: 'Country Already Exists'}
        end
    end

    def update
        begin
            @updateCountry = Country.update(params[:id], country_params)
            if @updateCountry.valid?
                @updateCountry.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        country = Country.find_by id: params[:id]
        if country
            country.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def country_params
        params.require(:countries).permit(:name, :description, :isd_code, :iso_code, :continent_id)
    end
end

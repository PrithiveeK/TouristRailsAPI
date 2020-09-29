class Api::MasterData::CitiesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "cities.status = 'ACTIVE'"
        filter += " and cities.id = #{params[:id].to_i}" if params[:id]
        filter += " and cities.name LIKE = '%#{params[:name]}%'" if params[:name]

        cities = City.left_outer_joins(:country).select(
            "cities.*, countries.name as country_name"
        ).where(filter)

        render json: {code: 200, data: cities, msg: 'Fetched Successfully'}
    end

    def create
        @newCity = City.create(city_params)
        if @newCity.valid?
            @newCity.save
            render :created
        else
            render json: {code: 400, msg: 'City Already Exists'}
        end
    end

    def update
        begin
            @updateCity = City.update(params[:id], city_params)
            if @updateCity.valid?
                @updateCity.save
                render :updated
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        city = City.find_by id: params[:id]
        if city
            city.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def city_params
        params.require(:cities).permit(:name, :description, :airport_code, :std_code, :country_id)
    end
end

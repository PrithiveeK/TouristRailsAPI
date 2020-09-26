class Api::MasterData::ContinentsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "continents.status = 'ACTIVE'"
        filter += " and continents.id = #{params[:id].to_i}" if params[:id]
        filter += " and continents.name LIKE = '%#{params[:name]}%'" if params[:name]

        continents = Continent.where(filter)

        render json: {code: 200, data: continents, msg: 'Fetched Successfully'}
    end

    def create
        @newContinent = Continent.create(continent_params)
        if @newContinent.valid?
            @newContinent.save
            render json: {code: 201, data: @newContinent, msg: 'Added Continent Successfully'}
        else
            render json: {code: 400, msg: 'Continent Already Exists'}
        end
    end

    def update
        begin
            updateContinent = Continent.update(params[:id], continent_params)
            if updateContinent.valid?
                updateContinent.save
                render json: {code: 200, data: updateContinent, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateContinent, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        continent = Continent.find_by id: params[:id]
        if continent
            continent.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def continent_params
        params.require(:continents).permit(:name, :description)
    end

end

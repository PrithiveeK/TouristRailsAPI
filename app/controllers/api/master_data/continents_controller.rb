class Api::MasterData::ContinentsController < ApplicationController
    before_action :authorize_request

    def index
        @continents = Continent.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @continents = @continents.where(id: params[:id].to_i)
        end
        if params[:name]
            @continents = @continents.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @continents}
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

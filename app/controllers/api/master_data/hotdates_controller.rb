class Api::MasterData::HotdatesController < ApplicationController
    # before_action :authorize_request

    def index
        @hotDates = Hotdate.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @hotdates = @hotdates.where(id: params[:id].to_i)
        end
        if params[:name]
            @hotdates = @hotdates.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @hotDates}
    end

    def create
        @newHotDate = Hotdate.create(hotdate_data)
        if @newHotDate.valid?
            @newHotDate.save
            render json: {code: 201, data: @newHotDate, msg: 'Added Hotdate Successfully'}
        else
            render json: {code: 400, msg: 'Hotdate Already Exists'}
        end
    end

    def update
        begin
            updateHotDate = Hotdate.update(params[:id], hotdate_data)
            if updateHotDate.valid?
                updateHotDate.save
                render json: {code: 200, data: updateHotDate, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        hotDate = Hotdate.find_by id: params[:id]
        if hotDate
            hotDate.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def hotdate_data
        hotdate_params[:from_date] = Date.strptime(hotdate_params[:from_date], "%Y-%m-%d") if hotdate_params[:from_date]
        hotdate_params[:to_date] = Date.strptime(hotdate_params[:to_date], "%Y-%m-%d") if hotdate_params[:to_date]
        if !hotdate_params[:country_id]
            hotdate_params[:country_id] = nil
            hotdate_params[:is_all_country] = true
        else
            hotdate_params[:is_all_country] = false
        end
        if !hotdate_params[:city_id]
            hotdate_params[:city_id] = nil
            hotdate_params[:is_all_city] = true
        else
            hotdate_params[:is_all_city] = false
        end
        return hotdate_params
    end

    def hotdate_params
        params.require(:hotdates).permit(
            :name,
            :description,
            :is_all_country,
            :is_all_city,
            :country_id,
            :city_id,
            :hotdate_difficulty_id,
            :from_date,
            :to_date
        )
    end
end

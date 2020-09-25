class Api::MasterData::RoomTypesController < ApplicationController
    # before_action :authorize_request

    def index
        @rooms = RoomType.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @rooms = @rooms.where(id: params[:id].to_i)
        end
        if params[:name]
            @rooms = @rooms.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @rooms}
    end

    def create
        @newRoom = RoomType.create(room_params)
        if @newRoom.valid?
            @newRoom.save
            render json: {code: 201, data: @newRoom, msg: 'Added RoomType Successfully'}
        else
            render json: {code: 400, msg: 'RoomType Already Exists'}
        end
    end

    def update
        begin
            updateRoom = RoomType.update(params[:id], room_params)
            if updateRoom.valid?
                updateRoom.save
                render json: {code: 200, data: updateRoom, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateRoom, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        room = RoomType.find_by id: params[:id]
        if room
            room.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def room_params
        params.require(:room_types).permit(:name, :description)
    end
end

class Api::MasterData::RoomTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "room_types.status = 'ACTIVE'"
        filter += " and room_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and room_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        room_types = RoomType.where(filter)

        render json: {code: 200, data: room_types, msg: 'Fetched Successfully'}
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

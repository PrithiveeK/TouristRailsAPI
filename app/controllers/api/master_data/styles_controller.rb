class Api::MasterData::StylesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "styles.status = 'ACTIVE'"
        filter += " and styles.id = #{params[:id].to_i}" if params[:id]
        filter += " and styles.name LIKE = '%#{params[:name]}%'" if params[:name]

        styles = Style.where(filter)

        render json: {code: 200, data: styles, msg: 'Fetched Successfully'}
    end

    def create
        @newStyle = Style.create(style_params)
        if @newStyle.valid?
            @newStyle.save
            render json: {code: 201, data: @newStyle, msg: 'Added Style Successfully'}
        else
            render json: {code: 400, msg: 'Style Already Exists'}
        end
    end

    def update
        begin
            updateStyle = Style.update(params[:id], style_params)
            if updateStyle.valid?
                updateStyle.save
                render json: {code: 200, data: updateStyle, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateStyle, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        style = Style.find_by id: params[:id]
        if style
            style.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def style_params
        params.require(:styles).permit(:name, :description)
    end
end

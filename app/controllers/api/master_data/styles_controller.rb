class Api::MasterData::StylesController < ApplicationController
    # before_action :authorize_request

    def index
        @styles = Style.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @styles = @styles.where(id: params[:id].to_i)
        end
        if params[:name]
            @styles = @styles.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @styles}
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

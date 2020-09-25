class Api::MasterData::TitlesController < ApplicationController
    before_action :authorize_request

    def index
        titles = Title.where(status: 'ACTIVE').order(:id)
        if params[:id]
            titles = titles.where(id: params[:id].to_i)
        end
        if params[:name]
            titles = titles.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: titles}
    end

    def create
        newTitle = Title.create(title_params)
        if newTitle.valid?
            newTitle.save
            render json: {code: 201, data: newTitle, msg: 'Created Title Successfully'}
        else
            render json: {code: 400, msg: 'Title Already Exists'}
        end
    end

    def update
        begin
            updateTitle = Title.update(params[:id], title_params)
            if updateTitle.valid?
                updateTitle.save
                render json: {code: 200, data: updateTitle, msg: 'Updated Sucessfully!'}
            else
                render json: {code: 400, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        title = Title.find_by id: params[:id]
        if title
            title.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def title_params
        params.require(:titles).permit(:name, :description)
    end
end

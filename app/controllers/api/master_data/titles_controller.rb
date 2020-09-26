class Api::MasterData::TitlesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "titles.status = 'ACTIVE'"
        filter += " and titles.id = #{params[:id].to_i}" if params[:id]
        filter += " and titles.name LIKE = '%#{params[:name]}%'" if params[:name]

        titles = Title.where(filter)

        render json: {code: 200, data: titles, msg: 'Fetched Successfully'}
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

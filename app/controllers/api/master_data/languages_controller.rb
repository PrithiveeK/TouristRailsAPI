class Api::MasterData::LanguagesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "languages.status = 'ACTIVE'"
        filter += " and languages.id = #{params[:id].to_i}" if params[:id]
        filter += " and languages.name LIKE = '%#{params[:name]}%'" if params[:name]

        languages = Language.where(filter)

        render json: {code: 200, data: languages, msg: 'Fetched Successfully'}
    end

    def create
        @newLanguage = Language.create(language_params)
        if @newLanguage.valid?
            @newLanguage.save
            render json: {code: 201, data: @newLanguage, msg: 'Added Language Successfully'}
        else
            render json: {code: 400, msg: 'Language Already Exists'}
        end
    end

    def update
        begin
            updateLanguage = Language.update(params[:id], language_params)
            if updateLanguage.valid?
                updateLanguage.save
                render json: {code: 200, data: updateLanguage, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateLanguage, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        language = Language.find_by id: params[:id]
        if language
            language.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def language_params
        params.require(:languages).permit(:name, :description, :language_iso_code)
    end

end

class Api::MasterData::LanguagesController < ApplicationController
    before_action :authorize_request

    def index
        @languages = Language.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @languages = @languages.where(id: params[:id].to_i)
        end
        if params[:name]
            @languages = @languages.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @languages}
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

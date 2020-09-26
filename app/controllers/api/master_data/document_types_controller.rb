class Api::MasterData::DocumentTypesController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "document_types.status = 'ACTIVE'"
        filter += " and document_types.id = #{params[:id].to_i}" if params[:id]
        filter += " and document_types.name LIKE = '%#{params[:name]}%'" if params[:name]

        document_types = DocumentType.where(filter)

        render json: {code: 200, data: document_types, msg: 'Fetched Successfully'}
    end

    def create
        @newDoc = DocumentType.create(doc_params)
        if @newDoc.valid?
            @newDoc.save
            render json: {code: 201, data: @newDoc, msg: 'Added DocumentType Successfully'}
        else
            render json: {code: 400, msg: 'DocumentType Already Exists'}
        end
    end

    def update
        begin
            updateDoc = DocumentType.update(params[:id], doc_params)
            if updateDoc.valid?
                updateDoc.save
                render json: {code: 200, data: updateDoc, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateDoc, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        doc = DocumentType.find_by id: params[:id]
        if doc
            doc.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def doc_params
        params.require(:document_types).permit(:name, :description)
    end
end

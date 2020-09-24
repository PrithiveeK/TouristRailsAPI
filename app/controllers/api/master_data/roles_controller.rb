class Api::MasterData::RolesController < ApplicationController
    # before_action :authorize_request

    def index
        @roles = Role.where(status: 'ACTIVE').order(:id)
        render json: {code: 200, data: @roles}
    end

    def create
        @newRole = Role.create(role_params)
        if @newRole.valid?
            @newRole.save
            render json: {code: 201, data: @newRole, msg: 'Added Role Successfully'}
        else
            render json: {code: 400, msg: 'Role Already Exists'}
        end
    end

    def update
        begin
            updateRole = Role.update(params[:id], role_params)
            if updateRole.valid?
                updateRole.save
                render json: {code: 200, data: updateRole, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateRole, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        role = Role.find_by id: params[:id]
        if role
            role.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def role_params
        params.require(:roles).permit(:name)
    end
end

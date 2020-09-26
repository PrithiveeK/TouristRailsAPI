class Api::MasterData::DepartmentsController < ApplicationController
    before_action :authorize_request
    before_action :master_data_search_view_access ,only: [:index, :show]
    before_action :master_data_add_edit_access, only: [:create, :update, :destroy]

    def index
        filter = "departments.status = 'ACTIVE'"
        filter += " and departments.id = #{params[:id].to_i}" if params[:id]
        filter += " and departments.name LIKE = '%#{params[:name]}%'" if params[:name]

        departments = Department.where(filter)

        render json: {code: 200, data: departments, msg: 'Fetched Successfully'}
    end

    def create
        @newDept = Department.create(dept_params)
        if @newDept.valid?
            @newDept.save
            render json: {code: 201, data: @newDept, msg: 'Added Department Successfully'}
        else
            render json: {code: 400, msg: 'Department Already Exists'}
        end
    end

    def update
        begin
            updateDept = Department.update(params[:id], dept_params)
            if updateDept.valid?
                updateDept.save
                render json: {code: 200, data: updateDept, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateDept, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        dept = Department.find_by id: params[:id]
        if dept
            dept.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def dept_params
        params.require(:departments).permit(:name, :description)
    end
end

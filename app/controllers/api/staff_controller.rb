class Api::StaffController < ApplicationController

    def index
        @staffs = User.left_outer_joins(:company).select(
            "users.*, companies.name as company_name"
        ).where("companies.id = $1 OR companies.parent_id = $1", 
            params[:company_id]
        )
        render json: {code: 200, data: @staffs}
    end
end

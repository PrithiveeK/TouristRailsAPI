class Api::MasterData::TicketsController < ApplicationController
    # before_action :authorize_request

    def index
        @tickets = Ticket.where(status: 'ACTIVE').order(:id)
        if params[:id]
            @tickets = @tickets.where(id: params[:id].to_i)
        end
        if params[:name]
            @tickets = @tickets.where("name LIKE ?", "%" + params[:name] + "%")
        end
        render json: {code: 200, data: @tickets}
    end

    def create
        @newTicket = Ticket.create(ticket_params)
        if @newTicket.valid?
            @newTicket.save
            render json: {code: 201, data: @newTicket, msg: 'Added Ticket Successfully'}
        else
            render json: {code: 400, msg: 'Ticket Already Exists'}
        end
    end

    def update
        begin
            updateTicket = Ticket.update(params[:id], ticket_params)
            if updateTicket.valid?
                updateTicket.save
                render json: {code: 200, data: updateTicket, msg: 'Updated Successfully!'}
            else
                render json: {code: 400, data: updateTicket, msg: 'Please try with different data'}
            end
        rescue => exception
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}    
        end
    end

    def destroy
        ticket = Ticket.find_by id: params[:id]
        if ticket
            ticket.destroy
            render json: {code: 200, msg: 'Deleted Successfully!'}    
        else
            render json: {code: 500, msg: 'Something went wrong. Please, Try again!'}
        end
    end

    private

    def ticket_params
        params.require(:tickets).permit(:name, :description)
    end
end

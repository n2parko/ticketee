class TicketsController < ApplicationController
    before_filter :find_project
    before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!, :except => [:index, :show]

    
    def index
        @tickets = @project.tickets.all
    end
    
    def new
        @ticket = @project.tickets.build
    end
    
    def create
        @ticket = @project.tickets.build(ticket_params)
        if @ticket.save
            flash[:notice] = "Ticket saved!"
            redirect_to [@project, @ticket]
        else
            flash[:alert] = "Ticket not saved"
            render :new
        end
    end
    
    def show
    end
    
    
    private
    def find_project
        @project = Project.find(params[:project_id])
    end
    
    private
    def find_ticket
        @ticket = Ticket.find(params[:id])
    end
    
    private
        def ticket_params
            params.require(:ticket).permit(:title, :description).merge!(:user => current_user)
        end
end

class ProjectsController < ApplicationController
    
    before_filter :find_project, :only => [:show, :edit, :update,:destroy]
    before_filter :authenticate_user!, :except => [:index, :show]
    
    def index
        @projects = Project.all
    end
    
    def new
       @project = Project.new
    end
    
    def create
        @project = Project.new(project_params)
        if @project.save
            flash[:notice] = "Project has been created"
            redirect_to @project
        else
            flash[:alert] = "Project has not been created."
            render :new
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update
        if @project.update(project_params)
            flash[:notice] = "Project has been updated"
            redirect_to @project
        else
            flash[:alert] = "Project failed to update"
            render :edit
        end
    end
    
    def destroy
        @project.destroy
        flash[:alert] = "Project has been deleted."
        redirect_to projects_path
    end
   
    
    ########
    
    private
    def find_project
        @project = Project.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The project you were looking for wasn't found!"
        redirect_to projects_path
    end
    
    
    private
        def project_params
            params.require(:project).permit(:name)
        end

end

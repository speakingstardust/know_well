class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create 
    @project = Project.new(project_params)
    @project.user = pundit_user

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def edit
  end

  def show
    @progress_notes = @project.progress_notes
    @tasks = @project.tasks
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :status, :department)
    end
end

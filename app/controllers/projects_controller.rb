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
    if pundit_user.is_admin? 
      @project.admin = pundit_user
    else
      @project.user = pundit_user
    end

    if @project.save
      redirect_to @project, notice: "Project successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Project Successfully updated.' 
    else 
      render "edit"
    end
  end

  def show
    @progress_notes = @project.progress_notes
    @tasks = @project.tasks
    if @tasks.any? 
      gon.rows = @project.generate_gantt_chart_rows
      gon.height = @tasks.count * 70 
    end
  end

  def destroy
    @project.destroy 
    redirect_to projects_url, notice: "#{@project.name} Successully destroyed."
  end 

  def master_gantt
    gon.rows = Project.generate_master_rows  
    gon.height = Task.count * 50
  end
  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :status, :department)
    end
end

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def index
    @search = Project.ransack(params[:q])
    @projects = @search.result.order(updated_at: :desc).page(params[:page])
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
    authorize @project
  end

  def update
    authorize @project
    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Project Successfully updated.' 
    else 
      render "edit"
    end
  end

  def show
    @progress_notes = @project.progress_notes
    @tasks = @project.tasks
    @comments = @project.comments
    if @tasks.any? 
      gon.rows = @project.generate_gantt_chart_rows
      gon.height = @tasks.count * 55 
      gon.criticalPath = true
    end
  end

  def destroy
    authorize @project
    @project.destroy 
    redirect_to projects_url, notice: "#{@project.name} Successully destroyed."
  end 

  def master_gantt
    authorize Project
    gon.rows = Project.generate_master_rows  
    gon.height = Task.count * 55
    gon.criticalPath = false
  end
  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :status, :department, :why_question, :market_question, :current_situation_question, :problems_question, :outcome_question, :customer_agreed_question, :requirements_question, :must_do_question, :must_not_do_question)
    end
end

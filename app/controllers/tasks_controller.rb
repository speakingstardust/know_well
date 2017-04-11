class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @project = Project.find(params[:project_id])

    @task = Task.new(project: @project)

    respond_to do |format|
      format.js
    end
  end

  def create
    @task = Task.new(task_params)

    @task.save

    @project = @task.project

    @tasks = @project.tasks
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def update 
    @task.update_attributes(task_params)

    @project = @task.project
    @tasks = @project.tasks
  end

  def delete
    @task = Task.find(params[:task_id])
    @project = @task.project

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project = @task.project
    @tasks = @project.tasks

    @task.destroy
  end

  def complete
    @task = Task.find(params[:task_id])
    @task.complete 
    @task.save
    @tasks = @task.project.tasks

    respond_to do |format|
      format.js
    end
  end

  def uncomplete
    @task = Task.find(params[:task_id])
    @task.uncomplete
    @task.save
    @tasks = @task.project.tasks

    respond_to do |format|
      format.js
    end
  end

  private
    def task_params
      params.require(:task).permit(:project_id, :start_date, :duration, :name, :description, :completed, :percent_complete)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
  end

  def edit
  end

  def show
    @progress_notes = @project.progress_notes
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end
end

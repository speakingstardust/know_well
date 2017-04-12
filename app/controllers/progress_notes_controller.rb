class ProgressNotesController < ApplicationController
  before_action :set_progress_note, only: [:edit, :update, :destroy]

  def new 
    @project = Project.find(params[:project_id])

    @progress_note = ProgressNote.new(project: @project)

    respond_to do |format|
      format.js
    end
  end

  def create 
    @progress_note = ProgressNote.new(progress_note_params)
    @progress_note.created_by = "#{pundit_user.first_name} #{pundit_user.last_name}"
    @project = @progress_note.project 
    @progress_notes = @project.progress_notes

    respond_to do |format|
      if @progress_note.save
        format.js
      else
        render 'new'
      end
    end
  end

  def edit 
    @project = Project.find(params[:project_id])
  end

  def update
    @progress_note.update_attributes(progress_note_params)

    @project = @progress_note.project

    @progress_notes = @project.progress_notes
  end

  def delete
    @progress_note = ProgressNote.find(params[:progress_note_id])
    @project = @progress_note.project 
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    @project = @progress_note.project 
    @progress_notes = @project.progress_notes

    @progress_note.destroy
  end

  private
    def progress_note_params
      params.require(:progress_note).permit(:note, :project_id, :attachment)
    end

    def set_progress_note
      @progress_note = ProgressNote.find(params[:id])
    end
end

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_any!

  def new 
    @project = Project.find(params[:project_id])

    @comment = Comment.new(project: @project)

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.creator_name = "#{pundit_user.first_name} #{pundit_user.last_name}"
    @project = @comment.project
    @comments = @project.comments

    respond_to do |format|
      if @comment.save
        format.js
      else
        render 'new'
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def update
    @comment.update_attributes(comment_params)

    @project = @comment.project

    @comments = @project.comments
  end

  def delete
    @comment = Comment.find(params[:comment_id])
    @project = @comment.project
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project = @comment.project
    @comments = @project.comments

    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:project_id, :subject, :comment)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end

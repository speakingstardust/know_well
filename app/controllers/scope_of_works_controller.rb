class ScopeOfWorksController < ApplicationController
  before_action :set_scope_of_work, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def index
    @customers = Customer.all
    @search = ScopeOfWork.ransack(params[:q])
    @scope_of_works = @search.result.page(params[:page])
  end

  def new 
    @scope_of_work = ScopeOfWork.new
    @customers = Customer.all
  end

  def create 
    @scope_of_work = ScopeOfWork.new(scope_of_work_params)
    
    if @scope_of_work.save
      redirect_to @scope_of_work, notice: "Scope of Work was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update 
    if @scope_of_work.update(scope_of_work_params)
      redirect_to @scope_of_work, notice: "Scope of Work was succesfully updated."
    else
      render :edit
    end
  end

  def destroy 
    @scope_of_work.destroy
    redirect_to scope_of_works_url, notice: "Scope of Work was successfully destroyed."
  end

  private 
    def set_scope_of_work
      @scope_of_work = ScopeOfWork.find(params[:id])
    end

    def scope_of_work_params
      params.require(:scope_of_work).permit(:name, :date_created, :created_by, :description, :file, :customer_id)
    end
end

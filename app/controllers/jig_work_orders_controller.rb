class JigWorkOrdersController < ApplicationController
  before_action :authenticate_any!
  before_action :set_jig_work_order, only: [:show, :edit, :update, :destroy]

  def index
    @jig_work_orders = JigWorkOrder.all
  end

  def show
  end

  def new 

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  
  def set_jig_work_order
    @jig_work_order = JigWorkOrder.find(params[:id])
  end
end

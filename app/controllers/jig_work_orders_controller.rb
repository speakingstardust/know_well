require 'pry'
class JigWorkOrdersController < ApplicationController
  before_action :authenticate_any!
  before_action :set_jig_work_order, only: [:show, :edit, :update, :destroy]

  def index
    @jig_work_orders = JigWorkOrder.all
  end

  def show
  end

  def new 
    @customer = Customer.find(params[:customer][:customer_id])
    @jigs = Jig.where(customer: @customer) 
    @jig_work_order = JigWorkOrder.new(customer: @customer)
    @jig_work_order.jig_work_order_line_items.build
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

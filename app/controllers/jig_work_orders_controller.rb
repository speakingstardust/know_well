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
    @jig_work_order = JigWorkOrder.new(jig_work_order_params)

    if @jig_work_order.save
      redirect_to @jig_work_order, notice: 'Jig Work Order was successfully created.'
    else
      render :new
    end
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

  def jig_work_order_params
    params.require(:jig_work_order).permit(:pickup_date, :pickup_time, :customer_id, :notes, :purchase_order, :returned, :verified_by, :verified, :verified_at, jig_work_order_line_items_attributes: [:id, :jig_id, :expected, :repaired, :actual, :_destroy])
  end
end

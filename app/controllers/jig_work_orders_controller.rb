require 'pry'
class JigWorkOrdersController < ApplicationController
  before_action :authenticate_any!
  before_action :set_jig_work_order, only: [:show, :edit, :update, :destroy, :packing_slip, :print]
  before_action :set_jig_work_order_for_status, only: [:receive, :complete, :ship, :verify_completed]

  layout "print", only: [:packing_slip, :print]
  
  def index
    @customers = Customer.all
    @search = JigWorkOrder.ransack(params[:q])
    @jig_work_orders = @search.result.order(:pickup_date).page(params[:page])
    authorize @jig_work_orders
  end

  def show
    authorize @jig_work_order
  end

  def print
    authorize @jig_work_order
  end

  def new 
    @customer = Customer.find(params[:customer][:customer_id])
    @jigs = Jig.where(customer: @customer) 
    @jig_work_order = JigWorkOrder.new(customer: @customer)
    authorize @jig_work_order
    @jig_work_order.jig_work_order_line_items.build
  end

  def create
    @jig_work_order = JigWorkOrder.new(jig_work_order_params)

    authorize @jig_work_order
    if @jig_work_order.save
      @jig_work_order.open!
      redirect_to @jig_work_order, notice: 'Jig Work Order was successfully created.'
    else
      render :new
    end
  end

  def edit
    @jig_work_order = JigWorkOrder.find(params[:id])
    authorize @jig_work_order
    @jigs = Jig.where(customer: @jig_work_order.customer)
  end

  def update
    authorize @jig_work_order
    if @jig_work_order.update(jig_work_order_params)
      redirect_to @jig_work_order, notice: 'Jig Order Successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @jig_work_order
    @jig_work_order.destroy
    redirect_to jig_work_orders_url, notice: 'Jig Work Order Sucessfully destroyed.'
  end

  def receive
    authorize @jig_work_order
    @jig_work_order.receive! 
    redirect_to @jig_work_order, notice: 'Jig Work Order Status Changed to Received'
  end
  
  def ship
    authorize @jig_work_order
    if @jig_work_order.ship! 
      redirect_to @jig_work_order, notice: 'Jig Work Order Status Changed to Shipped'
    else
      redirect_to @jig_work_order, alert: 'Jig Work Order Status Not Changed, Please check that actual cleaning numbers and returned date have been properly set before attempting again.'
    end
  end

  def packing_slip
    authorize @jig_work_order
    @customer = @jig_work_order.customer
  end

  def verify_completed
    authorize @jig_work_order
    @jig_work_order.verify_completed(:verified, pundit_user) 
    if @jig_work_order.save
      redirect_to @jig_work_order, notice: 'Jig Work Order Status Changed to Verified'
    else
      redirect_to @jig_work_order, notice: 'Jig Work Order Status Could not be Changed to Verified'
    end
  end

  def complete
    authorize @jig_work_order
    @jig_work_order.complete!
    redirect_to @jig_work_order, notice: 'Jig Work Order Status Changed to Completed'
  end
  private
  
  def set_jig_work_order
    @jig_work_order = JigWorkOrder.find(params[:id])
  end

  def set_jig_work_order_for_status
    @jig_work_order = JigWorkOrder.find(params[:jig_work_order_id])
  end

  def jig_work_order_params
    params.require(:jig_work_order).permit(:pickup_date, :pickup_time, :customer_id, :notes, :purchase_order, :returned, :verified_by, :verified, :verified_at, jig_work_order_line_items_attributes: [:id, :jig_id, :expected, :repaired, :actual, :_destroy])
  end
end

class JigOrdersController < ApplicationController
 
  def index
    @jig_orders = JigOrder.all
  end

  def show
  end

  def new
    @customers = Customer.all
    @jig_order = JigOrder.new
    3.times { @jig_order.jig_order_line_items.build }
  end

  def edit
  end

  def create 
    date = Date.civil(params[:date][:month].to_i, params[:date][:day].to_i, params[:date][:year].to_i)
    @jig_order = JigOrder.new(jig_order_params)
    @jig_order.date = date
    if @jig_order.save
      redirect_to @jig_order, notice: 'Jig Order was successfully created.'
    else
      render :new

    end
  end

  private 

  def set_jig_order
  	@jig_order = JigOrder.find(params[:id])
  end

  def jig_order_params
  	params.require(:jig_order).permit(:date, :customer_id, :notes)
  end

end

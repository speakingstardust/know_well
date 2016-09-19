class JigOrdersController < ApplicationController
  before_action :set_jig_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  
  def index
    @customers = Customer.all
    @search = JigOrder.ransack(params[:q])
    @jig_orders = @search.result.order(:date).page(params[:page])
  end

  def show
  end

  def new
    @customers = Customer.all
    @jig_order = JigOrder.new
  end

  def edit
    @customers = Customer.all
  end

  def create 
    @customers = Customer.all
    date = params[:date]
    date_object = Date.parse params["date"].values.join("-")
    @jig_order = JigOrder.new(jig_order_params)
    @jig_order.date = date_object
    if @jig_order.save
      redirect_to @jig_order, notice: 'Jig Order was successfully created.'
    else
      render :new

    end
  end

  def update
    if @jig_order.update(jig_order_params)
      redirect_to @jig_order, notice: 'Jig Order successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @jig_order.destroy
    redirect_to jig_orders_url, notice: 'Jig Order successfully destroyed.'
  end

  def new_report
    @customers = Customer.all
    @search = JigOrder.ransack(params[:q])
    @jig_orders = @search.result.order(:date).page(params[:page])

    respond_to do |format|
      format.html { render :new_report }
      format.pdf do
        pdf = JigSummaryPdf.new(@jig_orders, view_context)
        send_data pdf.render, filename: "jig_summary_#{params[:q][:date_gteq]}_to_#{params[:q][:date_lteq]}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  private 

  def set_jig_order
  	@jig_order = JigOrder.find(params[:id])
  end

  def jig_order_params
  	params.require(:jig_order).permit(:date, :customer_id, :notes, jig_order_line_items_attributes: [:id, :jig_id, :cleaned, :repaired])
  end

end

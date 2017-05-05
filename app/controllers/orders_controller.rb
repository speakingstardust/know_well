class OrdersController < ApplicationController
  before_action :authenticate_any!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @products = Product.needed 
    @order.order_line_items.build
  end

  def create
    parse_params
    @action = CreatesOrder.new(@products)
    success = @action.create
    if success
      redirect_to order_path(@action.order)
    else
      @action.order.destroy
      redirect_to new_order_url
      flash[:error] = "Order not generated, a problem has occured. Please ensure all products have all required information before trying again."
    end
  end

  def edit
  end

  def update
    if @order.update_attributes(order_params)
      redirect_to @order, notice: "Order successfully updated."
    else 
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order successfully destroyed."
  end

  private 
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:id, :date_created, :product_ids, order_line_items_attributes: [:id, :product_id, :amount_required, :ordered, :received, :_destroy]) 
    end

    def parse_params
      @products = Product.where(id: params[:order][:product_ids])
    end
end

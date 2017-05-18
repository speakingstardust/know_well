require "pry"
class OrdersController < ApplicationController
  before_action :authenticate_any!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.page(params[:page])
  end

  def show
  end

  def new
    @order = Order.new
    @products = Product.needed
    @raw_materials_category = Category.find_by_name("Raw Materials")
    @lab_supplies_category = Category.find_by_name("Lab Supplies")
    @consumables_category = Category.find_by_name("Consumables")
    @shop_supplies_category = Category.find_by_name("Shop Supplies")
    @maintenance_supplies_category = Category.find_by_name("Maintenance Supplies")
    @raw_materials = Product.where(category: @raw_materials_category).needed
    @lab_supplies = Product.where(category: @lab_supplies_category).needed
    @consumables = Product.where(category: @consumables_category).needed
    @shop_supplies = Product.where(category: @shop_supplies_category).needed
    @maintenance_supplies = Product.where(category: @maintenance_supplies).needed
    authorize @order
  end

  def create
    parse_params
    @action = CreatesOrder.new(@products)
    success = @action.create
    authorize @action.order
    if success
      redirect_to order_path(@action.order)
    else
      @action.order.destroy
      redirect_to new_order_url
      flash[:error] = "Order not generated, a problem has occured. Please ensure all products have all required information before trying again."
    end
  end

  def update
    authorize @order
    if @order.update_attributes(order_params)
      redirect_to @order, notice: "Order successfully updated."
    else 
      render :edit
    end
  end

  def destroy
    authorize @order
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

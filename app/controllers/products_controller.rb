require "pry"
class ProductsController < ApplicationController
  before_action :authenticate_any!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all
    @manufacturers = Manufacturer.all
    @categories = Category.all
    @q = Product.ransack(params[:q])
    @products = @q.result.page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create 
    @product = Product.new(product_params)

    authorize @product
    if @product.save
      redirect_to @product, notice: "Product successfully created."
    else 
      render :new 
    end
  end

  def edit
    authorize @product
  end

  def update 
    authorize @product
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else 
      render :edit
    end
  end

  def update_all_counts
    params['products'].keys.each do |id|
      @product = Product.find(id.to_i)
      authorize @product
      @product.update_attributes(params[:products][id].permit(:current_on_hand))
    end
    redirect_to products_url
  end

  def destroy
    authorize @product
    @product.destroy 
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  def count
    @q = Product.ransack(params[:q])
    @products = @q.result
  end

  private 
    def set_product
      @product = Product.find(params[:id])
    end

    def products_params
      params.require(:products).permit(products: [:id, :current_on_hand])
    end

    def product_params
      params.require(:product).permit(:id, :name, :manufacturer_id, :vendor_id, :part_number, :description, 
                                      :container, :unit, :units_per_container, :price_per_container, 
                                      :price_per_unit, :maximum_on_hand, :minimum_on_hand, :lead_time, 
                                      :current_on_hand, :order_amount, :category_id, :serial_number)
    end
end

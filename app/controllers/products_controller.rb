class ProductsController < ApplicationController
  before_action :authenticate_any!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create 
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product successfully created."
    else 
      render :new 
    end
  end

  def edit
  end

  def update 
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else 
      render :edit
    end
  end

  def destroy
    @product.destroy 
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private 
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :manufacturer_id, :vendor_id, :part_number, :description, 
                                      :container, :unit, :units_per_container, :price_per_container, 
                                      :price_per_unit, :maximum_on_hand, :minimum_on_hand, :lead_time, 
                                      :current_on_hand, :order_amount, :category)
    end
end

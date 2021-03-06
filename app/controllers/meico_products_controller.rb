class MeicoProductsController < ApplicationController
  before_action :authenticate_any!
  before_action :set_meico_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @meico_products = MeicoProduct.all
  end

  def new
    @meico_product = MeicoProduct.new
    authorize @meico_product
  end
  
  def create 
    @meico_product = MeicoProduct.new(meico_product_params)
    authorize @meico_product
    if @meico_product.save
      redirect_to @meico_product, notice: "MEICO Product successfully created."
    else 
      render :new
    end
  end

  def show
    authorize @meico_product
    @documents = policy_scope(Document.where(meico_product: @meico_product))
  end

  def edit
    authorize @meico_product
  end

  def update 
    authorize @meico_product
    if @meico_product.update(meico_product_params)
      redirect_to @meico_product, notice: "MEICO Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @meico_product
    @meico_product.destroy
    redirect_to meico_products_url, notice: "MEICO Product was successfully destroyed."
  end

  private
    def set_meico_product
      @meico_product = MeicoProduct.find(params[:id])
    end

    def meico_product_params
      params.require(:meico_product).permit(:name)
    end
end

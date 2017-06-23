require 'pry'
class SafetyDataSheetsController < ApplicationController
  before_action :set_safety_data_sheet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any! 

  def index
    @categories = Category.all
    @manufacturers = Manufacturer.all
    @search = SafetyDataSheet.ransack(params[:q])
    @safety_data_sheets = @search.result.page(params[:page])
  end

  def show
  end

  def new
    @product = Product.find(params[:product_id])

    @safety_data_sheet = SafetyDataSheet.new(product: @product)
  end

  def create 
    @safety_data_sheet = SafetyDataSheet.new(safety_data_sheet_params)

    if @safety_data_sheet.save
      redirect_to @safety_data_sheet.product, notice: "Safety Data Sheet was successfully created." 
    else
      render :new
    end
  end

  def edit
    @product = @safety_data_sheet.product
  end

  def update 
    if @safety_data_sheet.update(safety_data_sheet_params)
      redirect_to @safety_data_sheet.product, notice: "Safety Data Sheet was successfully updated." 
    else 
      render :edit
    end
  end

  def destroy 
    @safety_data_sheet.destroy
    redirect_to safety_data_sheets_url, notice: "Safety Data Sheet was successfully destroyed."
  end

  private 
    def set_safety_data_sheet
      @safety_data_sheet = SafetyDataSheet.find(params[:id])
    end

    def safety_data_sheet_params
      params.require(:safety_data_sheet).permit(:product_id, :pdf)
    end
end

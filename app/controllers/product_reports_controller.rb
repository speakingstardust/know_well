class ProductReportsController < ApplicationController
  before_action :authenticate_any! 
  def index
    @product_reports = ProductReport.all
  end

  def show
    @product_report = ProductReport.find(params[:id])
  end

  def new
    @product_report = ProductReport.new
    @categories = Product.categories
  end
  
  def create

  end

  private 

    def product_report_params
      params.require(:product_report).permit(:categories, :notes)
    end
end

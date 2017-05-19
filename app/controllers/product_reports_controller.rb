class ProductReportsController < ApplicationController
  before_action :authenticate_any! 
  before_action :set_product_report, only: [:show, :destroy]

  def index
    @product_reports = ProductReport.all
  end

  def show
  end

  def new
    @product_report = ProductReport.new
    @categories = Category.all
  end
  
  def create
    parse_params
    @notes = params[:product_report][:notes]
    @action = CreatesProductReport.new(@categories, @notes) 
    success = @action.create
    if success
      redirect_to product_report_path(@action.product_report)
    else
      @action.product_report.destroy
      redirect_to new_product_report_url
      flash[:error] = "Product Report not generated, a problem has occured."
    end
  end

  def destroy 
    @product_report.destroy 
    redirect_to product_reports_url, notice: "Product Report successfully destroyed."
  end

  private 
    def set_product_report
      @product_report = ProductReport.find(params[:id])
    end

    def parse_params
      @categories = Category.where(id: params[:product_report][:category_ids])
    end

    def product_report_params
      params.require(:product_report).permit(:categories, :notes, :category_ids)
    end
end

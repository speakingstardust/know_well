class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
    @search = Report.ransack(params[:q])
    @reports = @search.result.order(:created_at).page(params[:page])
    respond_to do |format|
      format.html { render 'index' }
      format.pdf {  @delivery_charge = params[:jig_order][:delivery_charge].nil? ? 0 : params[:jig_order][:delivery_charge] }
    end
  end

  def new
  end

  def show
  end

  def edit
  end


  private

    def set_report
      @report = Report.find(params[:id])
    end

end

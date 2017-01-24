require 'pry'
class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :print]
  layout "print", only: [:print]

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
    @report = Report.new
    @customers = Customer.all
  end

  def create
    @customer = Customer.find(params[:report][:customer])
    @date_from = Date.new(params[:report]["date_from(1i)"].to_i,
                         params[:report]["date_from(2i)"].to_i,
                         params[:report]["date_from(3i)"].to_i)
    @date_to =   Date.new(params[:report]["date_to(1i)"].to_i,
                         params[:report]["date_to(2i)"].to_i,
                         params[:report]["date_to(3i)"].to_i)
    binding.pry
    @action = CreatesReport.new(
      @customer,
      @date_from,
      @date_to,
      params[:report][:delivery_charge] || 0)
    success = @action.create
    if success
      redirect_to report_path(@action.report)
    else
      @report = @action.report
      render :new
    end
  end

  def show
  end

  def edit
  end

  def print
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: "Report was successfully destroyed."
  end


  private

    def set_report
      @report = Report.find(params[:id])
    end

end

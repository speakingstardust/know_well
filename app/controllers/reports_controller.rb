class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
    @customers = Customer.all 
    @jig_orders = JigOrder.all
  end

  def create
  end

  def edit
  end

  def update 

  end

  def destroy 

  end

  private

    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:start_date, :end_date, :delivery_charge)
    end

end
  

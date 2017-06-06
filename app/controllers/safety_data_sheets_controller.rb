require 'pry'
class SafetyDataSheetsController < ApplicationController
  before_action :set_safety_data_sheet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any! 

  def index
    @safety_data_sheets = SafetyDataSheet.all
  end

  def show
  end

  def new
    @safety_data_sheet = SafetyDataSheet.new
  end

  def create 
    @safety_data_sheet = SafetyDataSheet.new(safety_data_sheet_params)

    if @safety_data_sheet.save
      redirect_to @safety_data_sheet, notice: "Safety Data Sheet was successfully created." 
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @safety_data_sheet.update(safety_data_sheet_params)
      redirect_to @safety_data_sheet, notice: "Safety Data Sheet was successfully updated." 
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
      params.require(:safety_data_sheet).permit(:product_name, :manufacturer_name, :category, :pdf)
    end
end

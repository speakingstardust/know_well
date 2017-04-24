class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def index
    @manufacturers = Manufacturer.all
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      redirect_to @manufacturer, notice: "Manufacturer was successfully created."
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @manufacturer.update(manufacturer_params)
      redirect_to @manufacturer, notice: "Manufacturer was successfully updated."
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @manufacturer.destroy
    redirect_to manufacturers_url, notice: "Manfacturer was succefully destroyed."
  end

  private 
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :website, :phone)
    end

    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end
end

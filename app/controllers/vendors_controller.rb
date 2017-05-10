class VendorsController < ApplicationController
  before_action :authenticate_any!
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all
  end

  def show
  end

  def new
    @vendor = Vendor.new
    authorize @vendor
  end

  def create
    @vendor = Vendor.new(vendor_params)

    authorize @vendor
    if @vendor.save
      redirect_to @vendor, notice: "Vendor was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @vendor
  end

  def update
    authorize @vendor
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: "Vendor was successfully updated."
    else 
      render :edit
    end
  end

  def destroy
    authorize @vendor
    @vendor.destroy
    redirect_to vendors_url, notice: "Vendor was successfully destroyed."
  end

  private 
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit(:name, :website, :phone)
    end
end

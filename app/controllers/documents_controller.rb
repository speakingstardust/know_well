require 'pry'
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def new 
    @meico_product = MeicoProduct.find(params[:meico_product_id])
    @document = Document.new(meico_product: @meico_product)
  end

  def create
    @document = Document.new(document_params)
    @meico_product = MeicoProduct.find(params[:meico_product_id])
    @document.meico_product = @meico_product
    @document.created_by = "#{pundit_user.full_name}"    
    if @document.save
      redirect_to meico_product_document_path(@meico_product.id, @document), notice: "Document successfully created."
    else 
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @document.update(document_params)
      @document.updated_by = "#{pundit_user.full_name}"
      @document.save
      redirect_to meico_product_document_path(@document.meico_product.id, @document), notice: "Document successfully updated."
    else
      render :edit
    end
  end

  private 
    def set_document 
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:meico_product_id, :name, :category, :version, :date_issued, :created_by, :updated_by, :file)
    end
end

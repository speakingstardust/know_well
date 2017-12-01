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
    @document.created_by = "#{pundit_user.first_name} #{pundit_user.last_name}"    
    if @document.save
      redirect_to meico_product_document_path(@meico_product.id, @document), notice: "Document successfully created."
    else 
      render :new
    end
  end

  def show
  end

  private 
    def set_document 
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:meico_product_id, :name, :category, :version, :date_issued, :created_by, :updated_by, :file)
    end
end

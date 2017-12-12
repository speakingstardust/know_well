require 'pry'
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :download]
  before_action :authenticate_any!

  def new 
    @meico_product = MeicoProduct.find(params[:meico_product_id])
    @document = Document.new(meico_product: @meico_product)
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document
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
    authorize @document
  end

  def edit
    authorize @document
  end

  def update
    authorize @document
    unless params[:document][:current_version] == "0"
      if @document.update(document_params)
        @document.updated_by = "#{pundit_user.full_name}"
        @document.save
        redirect_to meico_product_document_path(@document.meico_product.id, @document), notice: "Document successfully updated."
      else
        render :edit
      end
    else
      redirect_to edit_meico_product_document_path(@document.meico_product.id, @document), notice: "Cannot set unset Current Version manually. Please set the current version, which will unset this version."
    end
  end

  def destroy
    authorize @document
    @meico_product = @document.meico_product
    if @document.document_mail_logs.empty?
      @document.destroy
      redirect_to meico_product_url(@meico_product), notice: "Document was successfully destroyed."
    else
      redirect_to meico_product_url(@meico_product), notice: "Document cannot be deleted after it has been shared."
    end
  end

  private 
    def set_document 
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:meico_product_id, :name, :category, :version, :date_issued, :created_by, :updated_by, :file, :current_version)
    end
end

require 'pry'
class DocumentMailLogsController < ApplicationController
  before_action :authenticate_any! 
  def new
    @document = Document.find(params[:document_id])
    @document_mail_log = DocumentMailLog.new(document: @document)
  end

  def create
    @document_mail_log = DocumentMailLog.new(document_mail_log_params)
    @document = @document_mail_log.document
    @meico_product = @document.meico_product
    if pundit_user.is_admin?
      @document_mail_log.admin = pundit_user
    else
      @document_mail_log.user = pundit_user
    end 
    @document_mail_log.sent_at = DateTime.now
    if @document_mail_log.save
      @document_mail_log.document.share_document(@document_mail_log.email)
      redirect_to @meico_product, notice: "Document successfully shared."
    else
      render :new
    end
  end

  private 
    def document_mail_log_params
      params.require(:document_mail_log).permit(:document_id, :customer_id, :user_id, :admin_id, :purpose, :email)
    end
end

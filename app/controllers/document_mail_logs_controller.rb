class DocumentMailLogsController < ApplicationController
  def new
    @document_mail_log = DocumentMailLog.new
  end
end

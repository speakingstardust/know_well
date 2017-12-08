class DocumentMailer < ApplicationMailer

  require 'open-uri'

  default from: 'noreply@autochemind.com'

  def share_document(email, document)
    @email = email 
    @document = document
    attachments[@document.file_file_name] = File.read(@document.file.url)
    mail to: @email, subject: "MEICO Document Request Response"
  end
end

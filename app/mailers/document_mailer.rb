class DocumentMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def share_document(email, document)
    @email = email 
    @document = document
    mail to: @email, subject: "MEICO Document Request Response"
  end
end

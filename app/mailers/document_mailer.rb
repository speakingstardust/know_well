class DocumentMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def share_document(email, document)
    @email = email 
    @document = document
    attachments["#{document.name} #{document.category}.pdf"] = File.read(document.file.url)
    mail to: @email, subject: "MEICO Document Request Response"
  end
end

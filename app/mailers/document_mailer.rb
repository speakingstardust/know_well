class DocumentMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def share_document(email, document)
    @email = email 
    @document = document
    file = open(@document.file.url).read
    attachments["#{@document.name} #{@document.category}.pdf"] = file
    mail to: @email, subject: "MEICO Document Request Response"
  end
end

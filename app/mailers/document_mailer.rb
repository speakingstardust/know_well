class DocumentMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def share_document(email, document)
    @email = email 
    @document = document
    attachments["#{@document.name} #{@document.category}.pdf"] = {
      mime_type: 'application/pdf',
      content: open(@document.file.url).read
    }
    mail to: @email, subject: "MEICO Document Request Response"
  end
end

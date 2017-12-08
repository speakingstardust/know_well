require "rails_helper"

RSpec.describe DocumentMailer, type: :mailer do
  describe 'share_document' do 
    let!(:document) { Document.create(name: "Test SDS", meico_product: create(:meico_product),
                                      category: 0, version: "1.0", date_issued: Date.today, 
                                      created_by: "Joe Blow", updated_by: "Joe Schmo", 
                                      file: File.new("#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf")) }
    let!(:email) { "test@ing.com" }
    let!(:mail) { described_class.share_document(email, document).deliver_now }

    it 'renders the subject' do 
      expect(mail.subject).to eq("MEICO Document Request Response")
    end

    it "renders the receiver email" do 
      expect(mail.to).to eq([email])
    end

    it "renders the sender email" do 
      expect(mail.from).to eq(['noreply@autochemind.com'])
    end

    it "has the attachment" do 
      mail.attachments.should have(1).attachment
    end
  end
end

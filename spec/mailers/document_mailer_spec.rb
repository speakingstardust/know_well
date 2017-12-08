require "rails_helper"

RSpec.describe DocumentMailer, type: :mailer do
  describe 'share_document' do 
    let!(:document) { FactoryGirl.create(:document) }
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

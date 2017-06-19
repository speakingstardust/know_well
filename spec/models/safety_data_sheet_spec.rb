require 'rails_helper'

RSpec.describe SafetyDataSheet, type: :model do
  describe "Validations" do 
    subject { described_class.new(product: create(:product), 
                                  pdf: File.new("#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf")) } 

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a product" do 
      subject.product = nil 
      expect(subject).to_not be_valid
    end
  end
  
  describe "Attachments" do
    it { should have_attached_file(:pdf) } 
    it { should validate_attachment_presence(:pdf) }
    it { should validate_attachment_content_type(:pdf).
         allowing("application/pdf").
         rejecting('image/png', 'image/jpg') }
    it { should belong_to(:product) }
  end
end

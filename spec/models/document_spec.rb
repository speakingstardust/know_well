require 'rails_helper'

RSpec.describe Document, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test SDS", category: 0, version: "1.0", 
                                  date_issued: Date.today, created_by: "Joe Blow", 
                                  updated_by: "Joe Schmo",
                                  file: File.new("#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf")) }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a name" do 
      subject.name = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do 
      subject.category = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a version number" do 
      subject.version = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a date_issued" do 
      subject.date_issued = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a file" do 
      subject.file = nil 

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to(:meico_product) }
    it {should have_many(:document_mail_logs) }
  end 

  describe "Logic" do 
    subject { FactoryGirl.create(:document, current_version: true) }
    let!(:second_document) { FactoryGirl.create(:document, name: "Second Document",
                                                meico_product: subject.meico_product, 
                                                current_version: false) }
    let!(:third_document) { FactoryGirl.create(:document, name: "Third Document", 
                                               meico_product: subject.meico_product,
                                               current_version: false) } 

    it "can send an email" do 
      expect { 
        subject.share_document("test@ing.com")
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "can properly set the current version flag" do 
      second_document.current_version = true
      second_document.save

      subject.reload
      second_document.reload 
      third_document.reload

      expect(subject.current_version).to eq(false)
      expect(second_document.current_version).to eq(true)
      expect(third_document.current_version).to eq(false)
    end

    it "will not allow no current version to be set" do
      subject.current_version = false 
      subject.save

      subject.reload 

      expect(subject.current_version).to eq(true)
    end
  end
end

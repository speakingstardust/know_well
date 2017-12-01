require 'rails_helper'

RSpec.describe Document, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test SDS", category: 0, version: "1.0", 
                                  date_issued: Date.today, created_by: "Joe Blow", 
                                  updated_by: "Joe Schmo",
                                  file: File.new("#{Rails.root}/spec/support/fixtures/test_pic.jpg")) }

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
  end 
end

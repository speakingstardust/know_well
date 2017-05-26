require 'rails_helper'

RSpec.describe SafetyDataSheet, type: :model do
  describe "Validations" do 
    subject { described_class.new(product_name: "Test Product", manufacturer_name: "Test Manufacturer", 
                                  category: 0) } 

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a product name" do 
      subject.product_name = nil 
      expect(subject).to_not be_valid
    end

    it "is not valid without a unique product name" do
      second_sds = create(:safety_data_sheet)
      subject
      expect(subject).to_not be_valid
    end

    it "is not valid without a manufacturer's name" do 
      subject.manufacturer_name = nil 
      expect(subject).to_not be_valid
    end

    it "is not valid without a category"
  end
end

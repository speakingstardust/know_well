require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  describe "validations" do 
    let(:manufacturer) { Manufacturer.new(name: "Test Manufacturer Name", phone: "5555555555", website: "www.manufacturer.test") }

    it "is valid with valid attributes" do 
      second_manufacturer = Manufacturer.create(name: "Second Manufacturer")
      manufacturer.name = "Test Manufacturer Name" 

      expect(manufacturer).to be_valid
    end

    it "is not valid without a name" do 
      manufacturer.name = nil
      expect(manufacturer).to_not be_valid
    end 

    it "is not valid without a unique name" do 
      second_manufacturer = Manufacturer.create(name: "Test Manufacturer") 
      manufacturer.name = "Test Manufacturer" 

      expect(manufacturer).to_not be_valid
    end
  end 

  describe "Logic" do 
    let(:manufacturer) { FactoryGirl.create(:manufacturer) }

    it "should properly format phone numbers to be displayed by number_to_phone" do 
      manufacturer.phone = "555-555-5555"
      manufacturer.save 

      expect(manufacturer.phone).to eq("5555555555")
    end
  end
end

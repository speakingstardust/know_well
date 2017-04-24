require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  describe "validations" do 
    let(:manufacturer) { Manufacturer.new }

    it "is valid with valid attributes" do 
      second_manufacturer = Manufacturer.create(name: "Second Manufacturer")
      manufacturer.name = "Test Manufacturer Name" 

      expect(manufacturer).to be_valid
    end

    it "is not valid without a name" do 
      expect(manufacturer).to_not be_valid
    end 

    it "is not valid without a unique name" do 
      second_manufacturer = Manufacturer.create(name: "Test Manufacturer") 
      manufacturer.name = "Test Manufacturer" 

      expect(manufacturer).to_not be_valid
    end
  end 
end

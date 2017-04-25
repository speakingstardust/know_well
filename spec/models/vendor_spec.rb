require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "validations" do 
    let (:vendor) { Vendor.new }

    it "is valid with valid attributes" do 
      second_vendor = Vendor.create(name: "Unique Vendor")
      vendor.name = "Test Vendor" 
      vendor.phone = "555-555-5555"
      vendor.website = "www.google.com"

      expect(vendor).to be_valid
    end

    it "is not valid without a name" do 
      vendor.phone = "555-555-5555"
      vendor.website = "www.google.com"

      expect(vendor).to_not be_valid
    end

    it "is not valid without a unique name" do 
      second_vendor = Vendor.create(name: "Test Vendor")
      vendor.name = "Test Vendor" 

      expect(vendor).to_not be_valid
    end

    it "is not valid without a phone number" do 
      vendor.name = "Test Vendor"
      vendor.website = "www.google.com"

      expect(vendor).to_not be_valid
    end

    it "is not valid without a website" do 
      vendor.name = "Test Vendor" 
      vendor.phone = "555-555-5555"

      expect(vendor).to_not be_valid
    end
  end
end

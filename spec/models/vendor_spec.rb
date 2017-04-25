require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "validations" do 
    subject { described_class.new(name: "Test Vendor", website: "www.google.com", phone: "5555555555") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a name" do 
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a unique name" do 
      second_vendor = Vendor.create(name: "Test Vendor", website: "www.google.com", phone: "5555555555")
      subject.name = "Test Vendor"

      expect(subject).to_not be_valid
    end

    it "is not valid without a phone number" do 
      subject.phone = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a website" do 
      subject.website = nil

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
  end

  describe "Logic" do 
    it "formats a phone number properly for displaying in view" do
      vendor = FactoryGirl.create(:vendor)
      vendor.phone = "555-555-5555"
      expect(vendor.phone).to eq("5555555555")
    end
  end 
end

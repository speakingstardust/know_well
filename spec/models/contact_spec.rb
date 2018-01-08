require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "Validations" do 
    subject { described_class.new(customer: create(:customer), first_name: "Steve", last_name: "Jobs",
                                  phone: "5555555555", fax: "5555555555", email: "steve@apple.com",
                                  kind: 0, note: "Test notes") }

    it "should be valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "should not be valid without a customer" do 
      subject.customer = nil 

      expect(subject).to_not be_valid
    end

    it "should not be valid without a first name" do
      subject.first_name = nil 

      expect(subject).to_not be_valid
    end

    it "should not be valid without a last name" do
      subject.last_name = nil 

      expect(subject).to_not be_valid
    end 

    it "should not be valid without a phone number" do
      subject.phone = nil 

      expect(subject).to_not be_valid
    end

    it "should not be valid without an email address" do
      subject.email = nil 

      expect(subject).to_not be_valid
    end
  end 
end

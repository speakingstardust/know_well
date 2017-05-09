require 'rails_helper'

RSpec.describe Jig, type: :model do
  describe "Validations" do
    let(:customer) { FactoryGirl.create(:customer) }
    subject { described_class.new(name: "Test Jig", cleaning_charge: 9.50, repair_charge: 6.50, customer: customer) }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end
  
    it "is invalid without a name" do 
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it "is invalid without a customer" do
      subject.customer = nil

      expect(subject).to_not be_valid
    end
  end
end

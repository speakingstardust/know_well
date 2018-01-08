require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "Validations" do 
    subject { described_class.new(street: "123 Somewhere Street", city: "Lancaster", state: "KY", 
                                  zip: "40444", category: "Physical") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a street address" do 
      subject.street = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a city" do 
      subject.city = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a state" do 
      subject.state = nil 

      expect(subject).to_not be_valid
    end
    it "is not valid without a zip" do
      subject.zip = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do
      subject.category = nil 

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to :customer }
  end
end

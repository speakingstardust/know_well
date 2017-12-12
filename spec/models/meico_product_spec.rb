require 'rails_helper'

RSpec.describe MeicoProduct, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test Meico Product Name") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a name" do 
      subject.name = nil 

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should have_many(:documents) }
  end
end

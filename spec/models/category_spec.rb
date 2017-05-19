require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test Category") }

    it "should be valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "should not be valid without a name" do 
      subject.name = nil 
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to :product_report } 
    it { should have_many :products } 
  end
end

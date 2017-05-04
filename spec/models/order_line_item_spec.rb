require 'rails_helper'

RSpec.describe OrderLineItem, type: :model do
  describe "Validations" do
    let(:order) { FactoryGirl.create(:order) } 
    let(:product) { FactoryGirl.create(:product) }
    subject { described_class.new(product: product, order: order, amount_required: 6) }
    
    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a product" do 
      subject.product = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an amount required" do
      subject.amount_required = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end
end

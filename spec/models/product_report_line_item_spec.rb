require 'rails_helper'

RSpec.describe ProductReportLineItem, type: :model do
  describe "Validations" do 
    let(:product) { FactoryGirl.create(:product) } 
    let(:product_report) { FactoryGirl.create(:product_report) } 
    subject { described_class.new(product: product, 
                                  current_amount: product.current_on_hand, 
                                  product_report: product_report) }

    it "should be valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "should not be valid without a product report" do 
      subject.product_report = nil 
      expect(subject).to_not be_valid
    end

    it "should not be valid without a product" do 
      subject.product = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to(:product) }
    it { should belong_to(:product_report) }
  end
end

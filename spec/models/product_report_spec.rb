require 'rails_helper'

RSpec.describe ProductReport, type: :model do
  describe "Validations" do
    subject { described_class.new(date_created: Date.today, notes: "Test notes") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end 

    it "is not valid without a creation date" do 
      subject.date_created = nil 
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should have_many(:product_report_line_items) }
    it { should have_many(:products) }
  end
  
  describe "Logic" do 
    let!(:raw_material) { FactoryGirl.create(:product, category: :raw_materials) }
    let!(:consumable) { FactoryGirl.create(:product, category: :consumables) }
    let!(:product_report) { FactoryGirl.create(:product_report) }

    it "can find all products when given a set of categories" do 
      product_report.find_products([:raw_materials, :consumables])

      expect(product_report.products).to include(raw_material, consumable) 
    end
  end
end

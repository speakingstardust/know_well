require 'rails_helper'

RSpec.describe ProductReport, type: :model do
  describe "Validations" do
    subject { described_class.new(date_created: Date.today, notes: "Test notes") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end 
  end

  describe "Associations" do 
    it { should have_many(:product_report_line_items) }
    it { should have_many(:products) }
  end
  
  describe "Logic" do 
    let!(:raw_material) { FactoryGirl.create(:product, category: create(:category)) }
    let!(:consumable) { FactoryGirl.create(:product, category: create(:category, name: "Consumables")) }
    let(:rm_category) { raw_material.category }
    let(:c_category) { consumable.category }
    let!(:product_report) { FactoryGirl.create(:product_report, categories: [rm_category, c_category]) }

    it "can find all products when given a set of categories" do 
      product_report.find_products

      expect(product_report.products).to include(raw_material, consumable) 
    end
  end
end

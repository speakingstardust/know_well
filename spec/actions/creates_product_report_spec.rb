require "rails_helper"
require "pry"

RSpec.describe CreatesProductReport do 
  let(:raw_materials) { FactoryGirl.create(:category) }
  let(:lab_supplies) { FactoryGirl.create(:category, name: "Lab Supplies") }
  let(:consumables) { FactoryGirl.create(:category, name: "Consumables") }
  let(:shop_supplies) { FactoryGirl.create(:category, name: "Shop Supplies") }
  let(:raw_material_product) { FactoryGirl.create(:product, current_on_hand: 20, category: raw_materials) } 
  let(:lab_supply_product) { FactoryGirl.create(:product, current_on_hand: 50, category: lab_supplies) } 
  let(:consumable_product) { FactoryGirl.create(:product, current_on_hand: 100, category: consumables) }
  let(:shop_supply_product) { FactoryGirl.create(:product, current_on_hand: 75, category: shop_supplies) }

  before(:each) do 
    @raw_material_product = raw_material_product
    @lab_supply_product = lab_supply_product
    @consumable_product = consumable_product
    @shop_supply_product = shop_supply_product
  end

  it "creates a product report given a set of categories" do 
    @creator = CreatesProductReport.new([raw_materials, lab_supplies, consumables], "Test Product Report Notes")

    @creator.build 

    expect(@creator.product_report.products).to include(@raw_material, @lab_supply, @consumable)
    expect(@creator.product_report.product_report_line_items.length).to eq(@creator.product_report.products.length)
    expect(@creator.product_report.notes).to eq("Test Product Report Notes")
  end

  it "saves a product report to the database after creating it" do 
    @creator = CreatesProductReport.new([raw_materials, lab_supplies], "Test Product Report Notes")

    @creator.create

    expect(@creator.product_report).to exist_in_database
  end
end

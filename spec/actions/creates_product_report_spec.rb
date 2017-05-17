require "rails_helper"
require "pry"

RSpec.describe CreatesProductReport do 
  let(:raw_material) { FactoryGirl.create(:product, current_on_hand: 20, category: 0) } 
  let(:lab_supply) { FactoryGirl.create(:product, current_on_hand: 50, category: 1) } 
  let(:consumable) { FactoryGirl.create(:product, current_on_hand: 100, category: 2) }
  let(:shop_supply) { FactoryGirl.create(:product, current_on_hand: 75, category: 3) }

  before(:each) do 
    @raw_material = raw_material
    @lab_supply = lab_supply 
    @consumable = consumable 
    @shop_supply = shop_supply
  end

  it "creates a product report given a set of categories" do 
    @creator = CreatesProductReport.new([:raw_materials, :lab_supplies, :consumables], "Test Product Report Notes")

    @creator.build 

    expect(@creator.product_report.products).to include(@raw_material, @lab_supply, @consumable)
    expect(@creator.product_report.product_report_line_items.length).to eq(@creator.product_report.products.length)
    expect(@creator.product_report.notes).to eq("Test Product Report Notes")
  end

  it "saves a product report to the database after creating it" do 
    @creator = CreatesProductReport.new([:raw_materials, :lab_supplies], "Test Product Report Notes")

    @creator.create

    expect(@creator.product_report).to exist_in_database
  end
end

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
    @included_products = [@raw_material, @lab_supply, @consumable]
  end

  it "creates a product report given a set of categories" do 
    @creator = CreatesProductReport.new(categories: [0, 1, 2])

    @creator.build 

    expect(@creator.product_report.products).to include(@included_products)
  end
end

require "rails_helper"
require "pry"

RSpec.describe CreatesOrder do 
  let(:at_min_product) { FactoryGirl.create(:product, current_on_hand: 24) } 
  let(:above_min_product) { FactoryGirl.create(:product, current_on_hand: 96) }
  let(:below_min_product) { FactoryGirl.create(:product, current_on_hand: 1) }

  before(:each) do 
    @at_min = at_min_product
    @above_min = above_min_product
    @below_min = below_min_product
    @low_products = [@at_min, @below_min]
    @products = [@at_min, @above_min, @below_min]
  end

  it "creates an order given a set of products" do 
    @creator = CreatesOrder.new(@low_products)

    @creator.build

    expect(@creator.order.products).to include(@at_min, @below_min)
  end
end

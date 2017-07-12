require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  describe "Validations" do 
    let!(:order) { FactoryGirl.create(:order) } 

    it "is valid with valid attributes" do
      expect(order).to be_valid
    end
  end

  describe "Associations" do 
    it { should have_many(:order_line_items) } 
    it { should have_many(:products) }
  end

  describe "Logic" do 
    it "should create Order Line Items given a selection of products" do 
      at_min = FactoryGirl.create(:product, current_on_hand: 24)
      above_min = FactoryGirl.create(:product, current_on_hand: 96)
      below_min = FactoryGirl.create(:product, current_on_hand: 1)
      products = [at_min, above_min, below_min]
      order = Order.new
      order.create_line_items(products)

      expect(order.products).to include(at_min, below_min)
      expect(order.products).to_not include(above_min)
      
      order_line_item = OrderLineItem.where(product: below_min).first

      expect(order_line_item.amount_required).to eq(3)
    end

    it "should automatically input date created at time of saving" do
      order = Order.new

      order.save 

      expect(order.date_created).to eq(Date.today)
    end

    it "should not be completed when all order line items haven't been received" do 
      order = FactoryGirl.create(:order_with_line_items, line_items_count: 5)

      expect(order.completed?).to be false
    end

    it "should not be complete when only some of the order line items have been recieved" do 
      order = FactoryGirl.create(:order_with_line_items)
      order.order_line_items.each do |line_item|
        line_item.received = true
        line_item.save
      end

      expect(order.completed?).to be true

      oli = FactoryGirl.create(:order_line_item, order: order)
      order.order_line_items << oli
      order.touch

      expect(oli.received?).to be false
      expect(order.completed?).to be false
    end

    it "should be completed when all order line items have been received" do
      order = FactoryGirl.create(:order_with_line_items, line_items_count: 5)
      order.order_line_items.each do |line_item|
        line_item.received = true
        line_item.save
      end

      expect(order.completed?).to be true
    end
  end
end

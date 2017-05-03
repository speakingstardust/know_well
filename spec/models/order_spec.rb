require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  describe "Validations" do 
    let(:order) { FactoryGirl.create(:order) } 

    it "is valid with valid attributes" do
      order 
      expect(order).to be_valid
    end
  end

  describe "Associations" do 
    it { should have_many(:order_line_items) } 
    it { should have_many(:products) }
  end

  describe "Logic" do 
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

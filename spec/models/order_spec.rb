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

    it "should set completed at when all order line items have been received" do
      order = FactoryGirl.create(:order)
      order.order_line_items.each do |line_item|
        line_item.received = true
      end

      expect(order.completed?).to be true
    end
  end
end

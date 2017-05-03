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
  end
end

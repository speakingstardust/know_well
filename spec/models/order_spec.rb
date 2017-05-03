require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  describe "Validations" do 
    let(:order) { FactoryGirl.create(:order) } 

    it "is valid with valid attributes" do
      order 
      expect(order).to be_valid
    end
    it "is not valid without a date created" do
      order.date_created = nil
      expect(order).to_not be_valid
    end
  end
end

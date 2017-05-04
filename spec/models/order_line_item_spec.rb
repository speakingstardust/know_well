require 'rails_helper'

RSpec.describe OrderLineItem, type: :model do
  describe "Validations" do
    let(:order_line_item) { OrderLineItem.new } 
    
    it "is valid with valid attributes" do 
      expect(order_line_item).to be_valid
    end
    it "is not valid without a product" 
    it "is not valid without an amount required" 
  end
end

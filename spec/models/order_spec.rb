require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  describe "Validations" do 
    let(:order) { FactoryGirl.create(:order) } 

    it "is valid with valid attributes"
    it "is not valid without any order line items" 
    it "is not valid without a date created" 
  end
end

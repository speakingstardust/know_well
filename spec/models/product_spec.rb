require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test Product", part_number: "12345", 
                                  description: "Test Product Description", 
                                  container: "Test Container", unit: "Test Unit", 
                                  units_per_container: 24, price_per_container: 4.50, 
                                  price_per_unit: 0.18, maximum_on_hand: 4.0, 
                                  minimum_on_hand: 1.5, lead_time: 14,
                                  current_on_hand: 2.0, order_amount: 0.0, category: 1) 
    }
                                  
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil 
      expect(subject).to_not be_valid
    end

    it "is not valid without a unique name" do
      second_product = FactoryGirl.create(:product)
      second_product.name = "Test Product"
      second_product.save

      expect(subject).to_not be_valid
    end

    it "is not valid without a unit" do
      subject.unit = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a container" do
      subject.container = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without units per container" do
      subject.units_per_container = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without either a price per unit or a price per container" do
      subject.price_per_unit = nil 
      
      expect(subject).to be_valid

      subject.price_per_unit = 0.18
      subject.price_per_container = nil 

      expect(subject).to be_valid

      subject.price_per_unit = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a maximum on hand" 
    it "is not valid without a minimum on hand"
    it "is not valid without a category"
  end
end

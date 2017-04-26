require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do 
    it "is valid with valid attributes"
    it "is not valid without a name" 
    it "is not valid without a unique name" 
    it "is not valid without a unit" 
    it "is not valid without a container"
    it "is not valid without units per container"
    it "is not valid without either a price per unit or a price per container"
    it "is not valid without a maximum on hand" 
    it "is not valid without a minimum on hand"
    it "is not valid without a category"
  end
end

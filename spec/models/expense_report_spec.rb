require 'rails_helper'

RSpec.describe ExpenseReport, type: :model do
  describe "Validations" do 
    subject { described_class.new(user: FactoryGirl.create(:user), date: Date.today, amount: 5.50,
                                  vendor: "Test Vendor", category: 1, note: "Test notes", other: "") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without either a user or an admin" do 
      
    end

    it "is not valid without a date" 
    it "is not valid without an amount" 
    it "is not valid without a vendor" 
    it "is not valid without a category"
    it "is not valid without an other when the category is set to other"
    # Other is 3 
  end
end

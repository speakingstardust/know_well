require 'rails_helper'

RSpec.describe ExpenseReport, type: :model do
  describe "Validations" do 
    subject { described_class.new(user: FactoryGirl.create(:user), admin: FactoryGirl.create(:admin),
                                  date: Date.today, amount: 5.50, vendor: "Test Vendor", 
                                  category: 1, note: "Test notes", other_note: "",
                                  payment_method: 1, 
                                  receipt: File.new("#{Rails.root}/spec/support/fixtures/test_pic.jpg")) }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is valid without an admin, with a user. Is not valid without both." do 
      subject.admin = nil
      expect(subject).to be_valid

      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "is valid without a user, with an admin. Is not valid without both" do 
      subject.user = nil 
      expect(subject).to be_valid

      subject.admin = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a date" do
      subject.date = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without an amount" do
      subject.amount = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a vendor" do
      subject.vendor = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do
      subject.category = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a payment method" do 
      subject.payment_method = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without an other when the category is set to other" do
      subject.other_note = nil

      expect(subject).to be_valid

      subject.category = "other"

      expect(subject).to_not be_valid
    end

    it "is not valid without a receipt photo" do 
      subject.receipt = nil

      expect(subject).to_not be_valid
    end
  end
end

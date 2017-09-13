require 'rails_helper'

RSpec.describe ScopeOfWork, type: :model do
  describe "Validations" do 
    subject { described_class.new(customer: FactoryGirl.create(:customer), name: "Test Scope of Work",
                                  date_created: Date.today, created_by: "Joe Blow", 
                                  description: "Test Description",
                                  file: File.new("#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf")) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end  
    it "is not valid without a name" do 
      subject.name = nil 

      expect(subject).to_not be_valid
    end
    it "is not valid without a customer"
    it "is not valid without a date_created"
    it "is not valid without a created_by"
    it "is not valid without a description" 
    it "is not valid without a file"
  end
end

require 'rails_helper'

RSpec.describe ProductReport, type: :model do
  describe "Validations" do
    subject { described_class.new(date_created: Date.today, notes: "Test notes") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end 

    it "is not valid without a creation date" do 
      subject.date_created = nil 
      expect(subject).to_not be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe DocumentMailLog, type: :model do
  describe "Validations" do 
    subject { described_class.new(user: create(:user), purpose: "Testing email logs.", 
                                  sent_at: DateTime.now, customer: create(:customer), 
                                  email: "test@ing.com") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without either a user or an admin" do
      expect(subject).to be_valid

      subject.user = nil
      expect(subject).to_not be_valid

      subject.admin = create(:admin)
      expect(subject).to be_valid
    end

    it "is not valid without a purpose" do 
      subject.purpose = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a sent_at timestamp" do 
      subject.sent_at = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do 
      subject.email = nil

      expect(subject).to_not be_valid
    end
  end
end

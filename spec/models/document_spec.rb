require 'rails_helper'

RSpec.describe Document, type: :model do
  describe "Validations" do 
    subject { described_class.new(name: "Test SDS", type: 0, version: "1.0", 
                                  date_issued: Date.today, created_by: "Joe Blow", 
                                  date_modified: Date.today, updated_by: "Joe Schmo") }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a name" do 
      subject.name = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a type" do 
      subject.type = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a version number" do 
      subject.version = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a date_issued" do 
      subject.date_issued = nil 

      expect(subject).to_not be_valid
    end

  end
end

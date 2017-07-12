require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Validations" do 
    subject { described_class.new(creator_name: "Test Creator", subject: "Test Comment Subject",
                                  comment: "Test comment for the project tracking system")
    } 

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a creator name" do 
      subject.creator_name = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a subject" do 
      subject.subject = nil 

      expect(subject).to_not be_valid
    end

    it "is not valid without a comment" do 
      subject.comment = nil 

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to(:project) }
  end
end

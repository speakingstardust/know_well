require 'rails_helper'

RSpec.describe JigWorkOrderLineItem, type: :model do
  describe "Validations" do 
    let(:jig) { create(:jig) }
    subject { described_class.new(jig: jig, expected: 5, repaired: 2, actual: 6) }

    it "should be valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "should not be valid without a jig" do 
      subject.jig = nil

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to :jig }
    it { should belong_to :jig_work_order }
  end
end

require 'rails_helper'

RSpec.describe Jig, type: :model do
  describe "Validations" do
    let(:customer) { FactoryGirl.create(:customer) }
    subject { described_class.new(name: "Test Jig", cleaning_charge: 9.50, repair_charge: 6.50, customer: customer) }

    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end
  
    it "is invalid without a name" do 
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it "is invalid without a customer" do
      subject.customer = nil

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should belong_to(:customer) } 
    it { should have_many(:jig_order_line_items) }
    it { should have_many :jig_orders }
    it { should have_many :jig_work_order_line_items }
    it { should have_many :jig_work_orders }
    it { should have_many :report_line_items }
  end
end

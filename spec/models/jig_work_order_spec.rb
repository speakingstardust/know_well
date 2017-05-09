require 'rails_helper'

RSpec.describe JigWorkOrder, type: :model do
  describe "Validations" do 
    let(:jig) { create(:jig) } 
    let(:jig_work_order_line_item) { JigWorkOrderLineItem.new(jig: jig, expected: 5, repaired: 0, actual: 5) }
    let(:return_date) { Date.today }
    let(:pickup_date) { Date.today - 3 }
    subject { described_class.new(jig_work_order_line_items: [jig_work_order_line_item], 
                                  purchase_order: "12345", notes: "Testing notes", 
                                  returned: return_date, pickup_date: pickup_date, 
                                  pickup_time: "AM", return_time: "PM") } 

    it "should be valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "should not be valid without a pickup date" do
      subject.pickup_date = nil 

      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do 
    it { should have_many :jig_work_order_line_items }
    it { should have_many :jigs }
    it { should have_and_belong_to_many :reports }
    it { should have_many :signatures }
    it { should belong_to :customer }
  end

  describe "State Machine" do 

  end
end

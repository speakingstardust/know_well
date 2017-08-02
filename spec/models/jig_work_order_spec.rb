require 'rails_helper'
require 'pry'

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
    let!(:jig_work_order) { create(:jig_work_order_with_line_items) }

    it "should move through the steps of the state machine properly" do 
      pundit_user = double("Joe Blow", first_name: "Joe", last_name: "Blow")

      expect(jig_work_order).to have_state(:created)
      expect(jig_work_order).to allow_event :open
      expect(jig_work_order).to transition_from(:created).to(:opened).on_event(:open)
      
      jig_work_order.open

      expect(jig_work_order).to have_state(:opened)
      expect(jig_work_order).to transition_from(:opened).to(:received).on_event(:receive)
      
      jig_work_order.receive

      expect(jig_work_order).to have_state(:received)
      expect(jig_work_order).to transition_from(:received).to(:shipped).on_event(:ship)

      jig_work_order.ship

      expect(jig_work_order).to have_state(:shipped)
      expect(jig_work_order).to transition_from(:shipped).to(:verified).on_event(:verify_completed, pundit_user)

      jig_work_order.verify_completed(:verified, pundit_user)

      expect(jig_work_order).to have_state(:verified)
      expect(jig_work_order).to transition_from(:verified).to(:completed).on_event(:complete, pundit_user)

      jig_work_order.complete(:completed, pundit_user)

      expect(jig_work_order).to have_state(:completed)
      expect(jig_work_order).to transition_from(:completed).to(:archived).on_event(:archive)

      jig_work_order.archive

      expect(jig_work_order).to have_state(:archived)
    end
  end

  describe "Logic" do 
    it "triggers the set_purchase_order callback before save" do 
      jig_work_order = build(:jig_work_order)

      expect(jig_work_order).to receive(:set_purchase_order)

      jig_work_order.save 
    end

    it "sets purchase order to current date and time if none is set" do 
      jig_work_order = build(:jig_work_order, purchase_order: nil) 

      jig_work_order.set_purchase_order 

      expect(jig_work_order.purchase_order).to eq(Time.now.strftime("%m%d%y-%H%M"))
    end
  end

  describe "Class Methods" do 
    let!(:old_work_order) { create(:jig_work_order) } 
    let!(:new_work_order) { create(:jig_work_order)}
    let!(:pundit_user) { double("Joe Blow", first_name: "Joe", last_name: "Blow") }

    before(:example) do 
      old_work_order.open
      old_work_order.receive
      old_work_order.ship
      old_work_order.verify_completed(:verified, pundit_user)
      old_work_order.complete(:completed, pundit_user)
      old_work_order.completed_at = DateTime.now - 61

      new_work_order.open
      new_work_order.receive
      new_work_order.ship
      new_work_order.verify_completed(:verified, pundit_user)
      new_work_order.complete(:completed, pundit_user)
      old_work_order.save
      new_work_order.save
    end


    it "can find and archive old completed orders" do 
      JigWorkOrder.archive_old_orders

      old_work_order.reload
      new_work_order.reload
      expect(old_work_order).to have_state(:archived)
      expect(new_work_order).to have_state(:completed)
    end
  end
end

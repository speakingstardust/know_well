require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe "validations" do
    let(:customer) { Customer.new }

    it "doesn't allow a blank name" do
      customer.name = ""

      customer.save

      expect(Customer.all.count).to eq(0)
    end

    it "maintains unique names" do
      customer_org = create(:customer, name: "Test Customer")
      customer_dup = Customer.new(name: "Test Customer")

      customer_dup.save

      expect(Customer.all.count).to eq(1)
    end
  end

end

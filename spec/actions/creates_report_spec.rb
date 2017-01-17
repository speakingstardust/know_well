require "rails_helper"
require "pry"

RSpec.describe CreatesReport do
  let(:date_from) { Date.today - 7 }
  let(:date_to) { Date.today }
  let(:creator) { CreatesReport.new(customer: @customer, date_from: date_from, date_to: date_to) }

  before(:example) do
    @customer = create(:customer) do |customer|
      order_attr = attributes_for :jig_order
      order_attr[:date] = Date.today - 7
      customer.jig_orders.create(order_attr)
      order_attr[:date] = Date.today - 6
      customer.jig_orders.create(order_attr)
      order_attr[:date] = Date.today - 5
      customer.jig_orders.create(order_attr)
      order_attr[:date] = Date.today - 4
      customer.jig_orders.create(order_attr)
      order_attr[:date] = Date.today - 3
      customer.jig_orders.create(order_attr)
    end
  end

  it "creates a new report given a customer and a set of dates" do
    creator.build

    expect(creator.report.customer).to eq(@customer)
    expect(creator.report.customer.jig_orders.count).to eq(5)
    expect(creator.report.date_from).to eq(date_from)
    expect(creator.report.date_to).to eq(date_to)
  end

  it "can find all associated jig orders for a customer" do
    output = creator.find_jig_orders(date_from, date_to, @customer)

    expect(output.count).to eq(5)
  end

  it "correctly sets the jig orders for the report" do
    creator.build

    expect(creator.report.jig_orders.size).to eq(5)
  end
end

require "rails_helper"
require "pry"

RSpec.describe CreatesReport do
  let(:date_from) { Date.today - 7 }
  let(:date_to) { Date.today }
  let(:customer) { Customer.create(name: "Test Customer") }
  let(:creator) { CreatesReport.new(customer: @customer, date_from: date_from, date_to: date_to) }
  let(:jig) { Jig.create!(name: "Test Jig", cleaning_charge: 9.50, repair_charge: 6.50) }
  let(:jig_order) { JigOrder.create!(date: (Date.today), customer: customer)}
  let(:jig_order_line_item) { JigOrderLineItem.create!(jig: jig, repaired: 5, cleaned: 60)}

  before(:example) do
    @customer = customer
    jig_order.jig_order_line_items << jig_order_line_item
    @customer.jigs << jig
  end

  it "creates a report given a customer and a date range" do
    creator.build

    expect(creator.report.customer.name).to eq("Test Customer")
  end

  it "builds the report and report line items" do
    creator.build

    expect(creator.report.customer.name).to eq("Test Customer")
    expect(creator.report.report_line_items.count).to eq(1)
    expect(creator.report.jig_orders.count).to eq(1)
  end

  it "saves the report to the database" do
    creator.create

    expect(creator.report).to exist_in_database
  end

end

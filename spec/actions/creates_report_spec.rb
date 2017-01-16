require "rails_helper"

RSpec.describe CreatesReport do
  it "creates a new report given a customer and a set of dates" do
    customer = create(:customer) do |customer|
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

    date_from = Date.today - 7
    date_to = Date.today

    creator = CreatesReport.new(customer: customer, date_from: date_from, date_to: date_to)

    creator.build

    expect(creator.report.customer).to eq(customer)
    expect(creator.report.customer.jig_orders.count).to eq(5)
    expect(creator.report.date_from).to eq(date_from)
    expect(creator.report.date_to).to eq(date_to)
  end
end

require 'rails_helper'
require 'pry'

RSpec.describe Report, type: :model do
  describe "attributes" do
    let(:report) { Report.new }
  end

  describe "calculations" do
    let(:report) { Report.new }
    let(:date_from) { Date.today -7 }
    let(:date_to) { Date.today }
    let(:customer) { Customer.create!(name: "Test Company") }
    let(:jig) { Jig.create!(name: "Test Jig", cleaning_charge: 9.50, repair_charge: 6.50) }
    let(:jig_order) { JigOrder.create!(date: (Date.today), customer: customer)}
    let(:jig_order_line_item) { JigOrderLineItem.create!(jig: jig, repaired: 5, cleaned: 60)}

    before(:example) do
      @customer = customer
      jig_order.jig_order_line_items << jig_order_line_item
      @customer.jigs << jig
    end


    it "can find jig orders based on the date_from, date_to, and customer" do
      report.customer = @customer
      report.date_from = date_from
      report.date_to = date_to

      report.find_jig_orders
      # jig_orders = report.jig_orders
      # binding.pry


      expect(report.jig_orders.length).to eq(1)
    end

    it "can create report line items based on jig orders" do
      # Given: A report with a customer. Customer has 5 Jig Orders,
      # each with 3 Jig Order Line Items, each with that customer's Jigs.
      report.customer = @customer
      report.date_from = date_from
      report.date_to = date_to
      orders = []
      5.times do |i|
        order = JigOrder.create(date: (Date.today - i), customer: customer)
        3.times do |i|
          line_item = JigOrderLineItem.create(jig: jig, repaired: 5, cleaned: 5)
          order.jig_order_line_items << line_item
        end
        orders << order
      end
      report.jig_orders << orders

      # When
      report.create_line_items(report.jig_orders)

      # Then
      expect(report.report_line_items.count).to eq(1)
    end

  end
end

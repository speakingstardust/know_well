require 'pry'

class CreatesReport
  attr_accessor :customer, :date_from, :date_to, :report, :delivery_charge

  def initialize(customer, date_from, date_to, delivery_charge)
    @customer = customer
    @date_from = date_from
    @date_to = date_to
    @delivery_charge = delivery_charge
  end

  def build
    self.report = Report.new(customer: @customer, date_from: @date_from, date_to: @date_to, delivery_charge: @delivery_charge)
    report.find_jig_orders
    report.create_line_items(report.jig_orders)
    report.total_up
  end


  def create
    build
    report.save
  end
end

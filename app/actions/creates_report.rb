require 'pry'

class CreatesReport
  attr_accessor :customer, :date_from, :date_to, :report

  def initialize(customer: {}, date_from: "", date_to: "")
    @customer = customer
    @date_from = date_from
    @date_to = date_to
  end

  def build
    self.report = Report.new(customer: @customer, date_from: @date_from, date_to: @date_to)
    report.find_jig_orders
    report.create_line_items(report.jig_orders)
  end


  def create
    build
    report.save
  end
end

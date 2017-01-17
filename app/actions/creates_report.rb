require 'pry'

class CreatesReport
  attr_accessor :customer, :date_from, :date_to, :report

  def initialize(customer: {}, date_from: "", date_to: "")
    @customer = customer
    @date_from = date_from
    @date_to = date_to
  end

  def build
    self.report = Report.new(customer: customer, date_from: date_from, date_to: date_to)
    report.jig_orders = find_jig_orders(@date_from, @date_to, @customer)

  end

  def find_jig_orders(date_from, date_to, customer)
    jig_orders = JigOrder.where(date: date_from..date_to, customer: customer)
  end

  def create

  end
end

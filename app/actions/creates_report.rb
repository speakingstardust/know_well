class CreatesReport
  attr_accessor :customer, :date_from, :date_to, :report

  def initialize(customer: {}, date_from: "", date_to: "")
    @customer = customer
    @date_from = date_from
    @date_to = date_to
  end

  def build
    self.report = Report.new(customer: customer, date_from: date_from, date_to: date_to)
  end

  def find_jig_orders(date_from, date_to)

  end

  def create

  end
end

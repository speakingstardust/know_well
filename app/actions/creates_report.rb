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
    report.find_jig_work_orders
    report.create_line_items(report.jig_work_orders)
    report.total_up
  end


  def create
    build
    report.save
  end

  def none_free? 
    result = []
    self.report.report_line_items.each do |rli|
      if rli.cleaning_charge_subtotal == 0.0 && rli.subtotal_cleaned > 0
        result << false
      end
      if rli.repair_charge_subtotal == 0.0 && rli.subtotal_repaired > 0
        result << false
      end
    end  
    if result.include? false
      return false
    else 
      return true
    end
  end
end

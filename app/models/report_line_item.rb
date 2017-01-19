class ReportLineItem < ActiveRecord::Base
  belongs_to :report
  belongs_to :jig

  after_initialize :init
  before_save :calculate_subtotals

  def init
    self.subtotal_repaired ||= 0
    self.subtotal_cleaned ||= 0
    self.cleaning_charge_subtotal ||= 0.0
    self.repair_charge_subtotal ||= 0.0
  end

  def calculate_subtotals
    self.cleaning_charge_subtotal = self.jig.cleaning_charge * self.subtotal_cleaned
    self.repair_charge_subtotal = self.jig.repair_charge * self.subtotal_repaired
  end

end

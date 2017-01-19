class ReportLineItem < ActiveRecord::Base
  belongs_to :report
  belongs_to :jig

  after_initialize :init

  def init
    self.subtotal_repaired ||= 0.0
    self.subtotal_cleaned ||= 0.0
    self.total ||= 0.0
  end
end

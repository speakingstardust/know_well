class ReportLineItem < ActiveRecord::Base
  belongs_to :report
  belongs_to :jig_order
  has_and_belongs_to_many :jig_order_line_items
end

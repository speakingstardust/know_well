class ReportLineItem < ActiveRecord::Base
  belongs_to :report
  has_many :jig_orders
  has_one :jig, through: :jig_order
  has_and_belongs_to_many :jig_order_line_items
end

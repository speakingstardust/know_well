class JigWorkOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :jig_work_order_line_items
  has_many :jigs, through: :jig_work_order_line_items
end
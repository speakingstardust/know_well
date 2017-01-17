class Report < ActiveRecord::Base
  has_many :report_line_items
  has_many :jig_orders, through: :report_line_items
  belongs_to :customer
end

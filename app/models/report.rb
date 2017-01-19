require 'pry'

class Report < ActiveRecord::Base
  has_many :report_line_items
  has_many :jig_orders, through: :report_line_items
  belongs_to :customer

  def find_jig_orders
    jig_orders = JigOrder.where(date: self.date_from..self.date_to, customer: self.customer)
    self.jig_orders << jig_orders
  end

  def create_line_items

  end

end

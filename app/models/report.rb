require 'pry'

class Report < ActiveRecord::Base
  has_many :report_line_items
  has_many :jig_orders
  belongs_to :customer

  def find_jig_orders
    jig_orders = JigOrder.where(date: self.date_from..self.date_to, customer: self.customer)
    self.jig_orders << jig_orders
  end

  def create_line_items
    jigs = self.find_jigs
    line_items = []
    jigs.each do |jig|
      line_item = ReportLineItem.create()
    end
  end

  def find_jigs
    jigs = []
    self.jig_orders.each do |jig_order|
      jigs << jig_order.jigs
    end
    jigs = jigs.flatten.uniq
  end

end

require 'pry'

class Report < ActiveRecord::Base
  has_many :report_line_items
  has_and_belongs_to_many :jig_orders
  belongs_to :customer

  def find_jig_orders
    jig_orders = JigOrder.where(date: self.date_from..self.date_to, customer: self.customer)
    self.jig_orders << jig_orders
  end

  def create_line_items(jig_orders)
    jigs = self.find_jigs
    jigs.each do |jig|
      jig_order_line_items = self.find_jig_order_line_items(jig, jig_orders)
      binding.pry
      line_item = ReportLineItem.new(report: self)
      jig_order_line_items.each do |joli|
        line.subtotal_cleaned += joli.cleaned
      end
    end
  end

  def find_jigs
    jigs = []
    self.jig_orders.each do |jig_order|
      jigs << jig_order.jigs
    end
    jigs = jigs.flatten.uniq
  end

  def find_jig_order_line_items(jig, jig_orders)
    jig_order_line_items = []
    jig_orders.each do |jig_order|
      jig_order_line_item = JigOrderLineItem.where(jig: jig, jig_order: jig_order)
      jig_order_line_items << jig_order_line_item
    end
    jig_order_line_items.flatten
  end
end
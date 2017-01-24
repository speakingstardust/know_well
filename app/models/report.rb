require 'pry'

class Report < ActiveRecord::Base
  has_many :report_line_items
  has_and_belongs_to_many :jig_orders
  belongs_to :customer

  validates :customer, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true

  def find_jig_orders
    jig_orders = JigOrder.where(date: self.date_from..self.date_to, customer: self.customer)
    self.jig_orders << jig_orders
  end

  def create_line_items(jig_orders)
    jigs = self.find_jigs
    jigs.each do |jig|
      jig_order_line_items = self.find_jig_order_line_items(jig, jig_orders)
      line_item = ReportLineItem.new(report: self, jig: jig)
      jig_order_line_items.each do |joli|
        if joli.cleaned.nil?
          joli.cleaned = 0
          line_item.subtotal_cleaned += joli.cleaned
        else
          line_item.subtotal_cleaned += joli.cleaned
        end
        if joli.repaired.nil?
          joli.repaired = 0
          line_item.subtotal_repaired += joli.repaired
        else
          line_item.subtotal_repaired += joli.repaired
        end
      end
      line_item.save
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

  def total_up
    total_cleaned = 0
    total_repaired = 0
    cleaning_charge_total = 0
    repair_charge_total = 0
    charges_subtotal = 0
    grand_total = 0

    self.report_line_items.each do |rli|
      unless rli.subtotal_cleaned.nil?
        total_cleaned += rli.subtotal_cleaned
      end
      unless rli.subtotal_repaired.nil?
        total_repaired += rli.subtotal_repaired
      end
      unless rli.cleaning_charge_subtotal.nil?
        cleaning_charge_total += rli.cleaning_charge_subtotal
      end
      unless rli.repair_charge_subtotal.nil?
        repair_charge_total += rli.repair_charge_subtotal
      end
    end
    charges_subtotal = cleaning_charge_total + repair_charge_total
    grand_total = charges_subtotal + self.delivery_charge

    self.total_cleaned = total_cleaned
    self.total_repaired = total_repaired
    self.cleaning_charge_total = cleaning_charge_total
    self.repair_charge_total = repair_charge_total
    self.charges_subtotal = charges_subtotal
    self.grand_total = grand_total
  end
end

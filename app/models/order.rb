require 'pry'
class Order < ActiveRecord::Base
  has_many :order_line_items, dependent: :destroy
  has_many :products, through: :order_line_items

  accepts_nested_attributes_for :order_line_items, :reject_if => lambda { |a| a[:product_id].blank? }, :allow_destroy => true

  before_save :set_date_created
  after_touch :check_and_set_completed_at

  time_for_a_boolean :completed


  def set_date_created
    self.date_created = Date.today
  end

  def check_and_set_completed_at
    result = []
    self.order_line_items.each do |li|
      if li.received? == false or li.received? == nil
        result << false
      elsif li.received? == true
        result << true
      end
    end
    if result.uniq.include?(false)
      self.completed = false
    else
      self.completed = true
    end
  end 

  def create_line_items(products)
    products.each do |product|
      if product.current_on_hand > product.minimum_on_hand
        next
      end
      current_amount = product.current_on_hand
      maximum_amount = product.maximum_on_hand
      units_per_container = product.units_per_container
      line_item = OrderLineItem.new(order: self, product: product)
      line_item.amount_required = ((maximum_amount - current_amount) / units_per_container).ceil
      line_item.save
    end
  end 
end

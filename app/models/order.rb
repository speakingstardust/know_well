class Order < ActiveRecord::Base
  has_many :order_line_items
  has_many :products, through: :order_line_items

  time_for_a_boolean :completed
end

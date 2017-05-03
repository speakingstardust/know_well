class OrderLineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  time_for_a_boolean :ordered
  time_for_a_boolean :received

end

class OrderLineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, touch: true

  time_for_a_boolean :ordered
  time_for_a_boolean :received

  validates :product, presence: true
  validates :amount_required, presence: true
end

class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :vendor

  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
  validates :container, presence: true
  validates :units_per_container, presence: true
  validates :price_per_container, presence: true, if: "price_per_unit.nil?"
  validates :price_per_unit, presence: true, if: "price_per_container.nil?"
  validates :maximum_on_hand, presence: true
  validates :minimum_on_hand, presence: true
end

class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :vendor
  has_many :order_line_items
  has_many :orders, through: :order_line_items

  enum category: [ :raw_materials, :lab_supplies, :consumables, :shop_supplies ]

  before_save :calculate_price_per_unit, if: "price_per_unit.nil?"
  before_save :calculate_price_per_container, if: "price_per_container.nil?"

  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
  validates :container, presence: true
  validates :units_per_container, presence: true
  validates :price_per_container, presence: true, if: "price_per_unit.nil?"
  validates :price_per_unit, presence: true, if: "price_per_container.nil?"
  validates :maximum_on_hand, presence: true
  validates :minimum_on_hand, presence: true
  validates :category, presence: true


  def calculate_price_per_unit
    self.price_per_unit = (self.price_per_container / self.units_per_container).round(2)
  end

  def calculate_price_per_container
    self.price_per_container = (self.price_per_unit * self.units_per_container).round(2)
  end
end

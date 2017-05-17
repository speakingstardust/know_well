require 'pry'
class ProductReport < ActiveRecord::Base
  has_many :product_report_line_items, dependent: :destroy
  has_many :products, through: :product_report_line_items

  before_validation :set_date_created

  validates :date_created, presence: true

  def set_date_created
    self.date_created ||= Date.today
  end

  def find_products(categories)
    products = []
    categories.each do |category|
      products << Product.try(category)
    end
    products.flatten
    self.products << products
  end

  def save_line_items
    self.product_report_line_items.each do |line_item|
      line_item.save
    end
  end
end

class ProductReport < ActiveRecord::Base
  has_many :product_report_line_items, dependent: :destroy
  has_many :products, through: :product_report_line_items

  before_save :set_date_created

  validates :date_created, presence: true

  def set_date_created
    self.date_created ||= Date.today
  end
end

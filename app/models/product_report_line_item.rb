class ProductReportLineItem < ActiveRecord::Base
  belongs_to :product_report
  belongs_to :product

  validates :product_report, presence: true
  validates :product, presence: true
  validates :current_amount, presence: true
end

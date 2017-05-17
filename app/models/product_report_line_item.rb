class ProductReportLineItem < ActiveRecord::Base
  belongs_to :product_report
  belongs_to :product
  
  before_create :set_current_amount

  validates :product_report, presence: true
  validates :product, presence: true

  def set_current_amount
    self.current_amount ||= self.product.current_on_hand
  end
end

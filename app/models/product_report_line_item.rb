class ProductReportLineItem < ActiveRecord::Base
  belongs_to :product_report
  belongs_to :product
end

class Category < ActiveRecord::Base
  belongs_to :product_report
  has_many :products
end

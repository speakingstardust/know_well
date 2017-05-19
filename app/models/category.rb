class Category < ActiveRecord::Base
  belongs_to :product_report
  has_many :products

  validates :name, presence: true
end

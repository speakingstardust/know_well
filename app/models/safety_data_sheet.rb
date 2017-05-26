class SafetyDataSheet < ActiveRecord::Base
  enum category: [:MEICO_products, :used_in_house, :raw_materials]

  validates :product_name, presence: true, uniqueness: true
end

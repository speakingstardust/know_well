class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :vendor

  validates :name, presence: true
end

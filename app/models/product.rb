class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :vendor

  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
  validates :container, presence: true
end

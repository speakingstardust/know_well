class Address < ActiveRecord::Base
  belongs_to :customer

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true 
  validates :category, presence: true
end

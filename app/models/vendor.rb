class Vendor < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :website, presence: true
end

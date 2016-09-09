class Customer < ActiveRecord::Base
	has_many :jigs
	has_many :jig_orders

	validates :name, presence: true, uniqueness: true

end

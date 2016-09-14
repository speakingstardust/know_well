class Customer < ActiveRecord::Base
	has_many :jigs
	has_many :jig_orders
	has_many :reports

	validates :name, presence: true, uniqueness: true

end

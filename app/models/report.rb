class Report < ActiveRecord::Base

	has_many :jig_orders
	belongs_to :customer

	validates :start_date, :presence
	validates :end_date, :presences 

end

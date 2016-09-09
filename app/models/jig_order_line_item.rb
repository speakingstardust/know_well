class JigOrderLineItem < ActiveRecord::Base

	belongs_to :jig_order
	has_many :jigs

	validates :jig_id, presence: true

end

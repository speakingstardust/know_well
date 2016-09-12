class JigOrderLineItem < ActiveRecord::Base

	belongs_to :jig_order
	belongs_to :jig



	validates :jig_id, presence: true

end

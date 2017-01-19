class JigOrderLineItem < ActiveRecord::Base

	belongs_to :jig_order
	belongs_to :jig
  has_and_belongs_to_many :report_line_items

	validates :jig_id, presence: true


end

class JigOrder < ActiveRecord::Base
	has_many :jig_order_line_items, :dependent => :destroy
	has_many :jigs, through: :jig_order_line_items
	belongs_to :customer

	accepts_nested_attributes_for :jig_order_line_items, :reject_if => lambda { |a| a[:jig_id].blank? }, :allow_destroy => true

	validates :date, presence: true
	validates :customer_id, presence: true


	def total_cleaned
		total_cleaned = 0 
		self.jig_order_line_items.each do |line_item|
			total_cleaned = total_cleaned + line_item.cleaned
		end
		total_cleaned
	end

	def total_repaired
		total_repaired = 0 
		self.jig_order_line_items.each do |line_item|
			total_repaired = total_repaired + line_item.repaired
		end
		total_repaired
	end

	

end

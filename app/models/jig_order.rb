class JigOrder < ActiveRecord::Base
	has_many :jig_order_line_items, :dependent => :destroy
	has_many :jigs, through: :jig_order_line_items
	belongs_to :customer
        has_and_belongs_to_many :reports

	accepts_nested_attributes_for :jig_order_line_items, :reject_if => lambda { |a| a[:jig_id].blank? }, :allow_destroy => true

	validates :date, presence: true
	validates :customer_id, presence: true

	attr_accessor :delivery_charge

end

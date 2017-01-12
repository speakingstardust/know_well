class Jig < ActiveRecord::Base
	belongs_to :customer
	has_many :jig_order_line_items
	has_many :jig_orders, through: :jig_order_line_items

	validates :name, presence: true
	validates :cleaning_charge, presence: true

end

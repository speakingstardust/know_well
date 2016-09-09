class Jig < ActiveRecord::Base
	belongs_to :customer
	has_many :jig_orders, through: :jig_order_line_items

	mount_uploader :image, ImageUploader

	validates :name, presence: true
	validates :cleaning_charge, presence: true

end

class Jig < ActiveRecord::Base
	belongs_to :customer

	mount_uploader :image, ImageUploader

	validates :name, presence: true
	validates :cleaning_charge, presence: true

end

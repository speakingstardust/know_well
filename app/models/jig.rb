class Jig < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	validates :name, presence: true
	validates :cleaning_charge, presence: true

end

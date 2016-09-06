class Jig < ActiveRecord::Base

	validates :name, presence: true
	validates :cleaning_charge, presence: true

end

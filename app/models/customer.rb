class Customer < ActiveRecord::Base
	has_many :jigs

	validates :name, presence: true, uniqueness: true

end

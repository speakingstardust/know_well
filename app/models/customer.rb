class Customer < ActiveRecord::Base
	has_many :jigs
	has_many :jig_orders
        has_many :reports
        has_many :scope_of_works
        has_many :document_mail_logs

	validates :name, presence: true, uniqueness: true

end

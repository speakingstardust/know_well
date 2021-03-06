class Customer < ActiveRecord::Base
	has_many :jigs
	has_many :jig_orders
        has_many :reports
        has_many :scope_of_works
        has_many :document_mail_logs
        has_many :addresses, dependent: :destroy
        has_many :contacts, dependent: :destroy

        accepts_nested_attributes_for :addresses, allow_destroy: true

	validates :name, presence: true, uniqueness: true

        enum payment: [:credit_card, :direct_deposit, :check_by_mail] 

end

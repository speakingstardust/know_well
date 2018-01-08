class Contact < ActiveRecord::Base
  belongs_to :customer

  enum kind: [:primary_billing, :secondary_billing, :primary_purchasing, :secondary_purchasing, :primary_production, :secondary_production]
end

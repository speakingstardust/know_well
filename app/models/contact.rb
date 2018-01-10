class Contact < ActiveRecord::Base
  belongs_to :customer

  validates :customer, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

  enum kind: [:primary_billing, :secondary_billing, :primary_purchasing, :secondary_purchasing, :primary_production, :secondary_production]

  def full_name 
    "#{self.first_name} #{self.last_name}"
  end
end

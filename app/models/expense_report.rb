require "pry"
class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  enum category: [:shop_fuel, :shop_supplies, :vehicle_fuel, :office_supplies, :other]

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
  validates :date, presence: true
  validates :amount, presence: true
  validates :vendor, presence: true
  validates :category, presence: true
  validates :other_note, presence: true, if: "self.other?"

end

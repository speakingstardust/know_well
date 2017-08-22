class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  enum category: [:fuel, :shop_supplies, :office_supplies, :other]

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
  validates :date, presence: true
  validates :amount, presence: true

end

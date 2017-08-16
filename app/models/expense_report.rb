class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  enum category: [:fuel, :shop_supplies, :office_supplies, :other]

end

require "pry"
class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  enum category: [:fuel, :shop_supplies, :office_supplies, :other]

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
  validates :date, presence: true
  validates :amount, presence: true
  validates :vendor, presence: true
  validates :category, presence: true
  validates :other_note, presence: true, if: "self.other?"

  before_create :add_user_or_admin

  def add_user_or_admin
    if pundit_user.is_admin?
      self.admin = pundit_user
    else
      self.user = pundit_user
    end
  end
end

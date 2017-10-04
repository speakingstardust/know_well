require "pry"
class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  enum category: [:shop_fuel, :shop_supplies, :vehicle_fuel, :office_supplies, :offsite_supplies, :other]
  enum payment_method: [:fuel_truck_10, :fuel_truck_11, :fuel_truck_12, :fuel_trailer_13, :visa, :mastercard, :lowes, :employee_reimbursement]

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
  validates :date, presence: true
  validates :amount, presence: true
  validates :vendor, presence: true
  validates :category, presence: true
  validates :payment_method, presence: true
  validates :other_note, presence: true, if: "self.other?"
  validates :receipt, attachment_presence: true

  has_attached_file :receipt, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  before_post_process :is_image?

  validates_attachment_content_type :receipt, content_type: ["application/pdf", "image/jpeg", "image/jpg", "image/png", "image/x-png", "image/gif"]

  def is_image?
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.receipt_content_type)
  end
end

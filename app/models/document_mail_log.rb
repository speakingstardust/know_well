class DocumentMailLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :customer
  belongs_to :document

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
  validates :sent_at, presence: true
  validates :email, presence: true
  validates :purpose, presence: true
end

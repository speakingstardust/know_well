class DocumentMailLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :customer

  validates :user, presence: true, if: "admin_id.nil?"
  validates :admin, presence: true, if: "user_id.nil?"
end

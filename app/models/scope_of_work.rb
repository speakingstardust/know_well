class ScopeOfWork < ActiveRecord::Base
  belongs_to :customer

  validates :name, presence: true
  validates :customer, presence: true
  validates :date_created, presence: true
  validates :created_by, presence: true
  validates :description, presence: true

  has_attached_file :file
  validates_attachment :file, presence: true,
    content_type: { content_type: "application/pdf" }
end

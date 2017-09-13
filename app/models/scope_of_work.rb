class ScopeOfWork < ActiveRecord::Base
  belongs_to :customer

  validates :name, presence: true
  validates :customer, presence: true

  has_attached_file :file
  validates_attachment :file, presence: true,
    content_type: { content_type: "application/pdf" }
end

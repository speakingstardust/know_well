class SafetyDataSheet < ActiveRecord::Base
  belongs_to :product

  validates :product, presence: true

  has_attached_file :pdf
  validates_attachment_presence :pdf
  validates_attachment :pdf, content_type: { content_type: "application/pdf" }

end

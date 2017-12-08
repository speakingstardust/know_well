class Document < ActiveRecord::Base
  belongs_to :meico_product
  has_many :document_mail_logs

  enum category: [:SDS, :TDS, :EDS, :Other]

  validates :name, presence: true 
  validates :category, presence: true
  validates :date_issued, presence: true
  validates :version, presence: true
  validates :file, presence: true

  has_attached_file :file, styles: { full: "2500x2500>", large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  before_post_process :is_image?

  validates_attachment_content_type :file, content_type: ["application/pdf"]

  def is_image? 
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.file_content_type)
  end

  def share_document(email)
    DocumentMailer.share_document(email, self).deliver_now
  end

end

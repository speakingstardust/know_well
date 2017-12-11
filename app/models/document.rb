class Document < ActiveRecord::Base
  belongs_to :meico_product
  has_many :document_mail_logs

  enum category: [:SDS, :TDS, :EDS, :Other]

  validates :name, presence: true 
  validates :category, presence: true
  validates :date_issued, presence: true
  validates :version, presence: true
  validates :file, presence: true

  has_attached_file :file, 
    :s3_permissions => :private

  validates_attachment_content_type :file, content_type: ["application/pdf"]


  def share_document(email)
    DocumentMailer.share_document(email, self).deliver_now
  end

end

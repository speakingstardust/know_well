require "pry"
class Document < ActiveRecord::Base
  belongs_to :meico_product
  has_many :document_mail_logs
  
  before_save :set_current_version

  scope :all_except, ->(document) { where.not(id: document) }
  scope :current_version, ->(document) { where(category: document.category, current_version: true) }

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

  def set_current_version
    if self.current_version_changed?
      if self.current_version == true
        previous_version = self.meico_product.documents.current_version(self).all_except(self).first
        if previous_version
          previous_version.current_version = false
          previous_version.save
        end
      elsif self.current_version == false
        if self.meico_product.documents.current_version(self).all_except(self).empty?
          return false
        end
      end
    end
  end

end

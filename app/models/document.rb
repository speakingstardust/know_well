require "pry"
class Document < ActiveRecord::Base
  belongs_to :meico_product
  has_many :document_mail_logs

  before_update :check_for_one_current_version, if: :current_version_false?
  after_save :set_current_version_to_false, if: :current_version_true?

  default_scope { order(current_version: :desc, version: :desc) }
  
  scope :all_except, ->(document) { where.not(id: document) }
  scope :current_version_true, ->(document) { where(category: Document.categories[document.category.to_sym], meico_product: document.meico_product, current_version: true) }

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

  def current_version_true?
    self.current_version == true
  end

  def current_version_false?
    self.current_version == false
  end

  def set_current_version_to_false
    self.class.current_version_true(self).all_except(self).update_all(current_version: false)
  end

  def check_for_one_current_version
    if self.class.count > 0
      unless self.class.current_version_true(self).all_except(self).any? 
        return false
      end
    end
  end

end

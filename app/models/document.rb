class Document < ActiveRecord::Base
  validates :name, presence: true 
  validates :category, presence: true
  validates :date_issued, presence: true
  validates :version, presence: true
  validates :file, presence: true

  has_attached_file :file, styles: { full: "2500x2500>", large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  before_post_process :is_image?

  validates_attachment_content_type :file, content_type: ["application/pdf","application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain", "image/jpeg", "image/jpg", "image/png", "image/x-png", "image/gif", "application/zip", "application/x-iwork-keynote-sffkey", "application/x-iwork-pages-sffpages", "application/x-iwork-numbers-sffnumbers"]

  def is_image? 
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.file_content_type)
  end

end

class ProgressNote < ActiveRecord::Base
  belongs_to :project, touch: true

  DOCUMENT_TYPES = ["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain", "application/zip", "application/x-iwork-keynote-sffkey", "application/x-iwork-pages-sffpages", "application/x-iwork-numbers-sffnumbers"]

  IMAGE_TYPES = ["image/jpeg", "image/pjepg", "image/png", "image/x-png", "image/gif"]

  has_attached_file :attachment, styles: { thumb: '100x100>', medium: '300x300>' }
  before_post_process :is_image?

  validates_attachment_content_type :attachment, :content_type => ["application/pdf","application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain", "image/jpeg", "image/pjepg", "image/png", "image/x-png", "image/gif", "application/zip", "application/x-iwork-keynote-sffkey", "application/x-iwork-pages-sffpages", "application/x-iwork-numbers-sffnumbers"]

  def is_image?
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.attachment_content_type)
  end
end

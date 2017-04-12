class ProgressNote < ActiveRecord::Base
  belongs_to :project

  has_attached_file :attachment, styles: { thumb: '100x100>', medium: '300x300>' }

  validates_attachment_content_type :attachment, :content_type => ["application/pdf","application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain", "image/jpeg", "image/jpg", "image/png", "application/zip", "application/x-iwork-keynote-sffkey", "application/x-iwork-pages-sffpages", "application/x-iwork-numbers-sffnumbers"]

end

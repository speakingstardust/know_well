class Document < ActiveRecord::Base

  validates :name, presence: true 
  validates :category, presence: true
  validates :date_issued, presence: true
  validates :version, presence: true

end

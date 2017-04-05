class ProjectNote < ActiveRecord::Base
  belongs_to :project
  

  validates :note, presence: true
end

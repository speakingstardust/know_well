class Comment < ActiveRecord::Base
  belongs_to :project

  validates :creator_name, presence: true 
  validates :subject, presence: true
  validates :comment, presence: true
end

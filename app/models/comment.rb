class Comment < ActiveRecord::Base

  validates :creator_name, presence: true 
  validates :subject, presence: true
  validates :comment, presence: true
end

class Comment < ActiveRecord::Base
  belongs_to :project

  before_save :set_creator_name

  validates :creator_name, presence: true 
  validates :subject, presence: true
  validates :comment, presence: true

  def set_creator_name
    self.creator_name = pundit_user.full_name
  end
end

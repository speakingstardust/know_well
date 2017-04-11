require "pry"
class Task < ActiveRecord::Base
  belongs_to :project

  acts_as_list scope: :project

  before_save :set_end_date

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :name, presence: true

  def set_end_date
    self.end_date = self.start_date + self.duration
  end

  def complete
    self.completed = true
  end

  def uncomplete
    self.completed = false
  end

  def up
    self.move_higher
  end

  def down
    self.move_lower
  end

  def top
    self.move_to_top
  end

  def bottom 
    self.move_to_bottom
  end
end

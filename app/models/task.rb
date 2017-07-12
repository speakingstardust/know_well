require "pry"
class Task < ActiveRecord::Base
  belongs_to :project, touch: true
  has_and_belongs_to_many :dependencies, class_name: "Task", join_table: :dependencies, foreign_key: "task_id", association_foreign_key: :dependent_task_id

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
    self.percent_complete = 100
  end

  def uncomplete
    self.completed = false
    self.percent_complete = 0
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

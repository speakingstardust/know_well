require "pry"
class Task < ActiveRecord::Base
  belongs_to :project

  before_save :set_end_date
  before_save :set_order

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :name, presence: true

  def set_end_date
    self.end_date = self.start_date + self.duration
  end

  def set_order 
    current_number = self.project.tasks.count  
    self.order = current_number + 1
  end

  def complete
    self.completed = true
  end

  def uncomplete
    self.completed = false
  end


end

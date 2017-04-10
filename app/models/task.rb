class Task < ActiveRecord::Base
  belongs_to :project

  before_save :set_end_date

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :name, presence: true

  def set_end_date
    self.end_date = self.start_date + self.duration
  end
end

class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  has_many :tasks, -> { order(position: :asc) }
  has_many :progress_notes, -> { order(created_at: :asc) }

  resourcify

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

  def self.owned_by(user)
    if user.is_admin? 
      where(admin: user)
    else
      where(user: user)
    end
  end

  def days_to_miliseconds(days)
    days * 24 * 60 * 60 * 1000
  end

  def generate_gantt_chart_rows
    @rows = []
    self.tasks.each do |task|
      row = []
      row << task.id.to_s
      row << task.name
      row << ""
      row << task.start_date.to_datetime.to_f * 1000
      row << task.end_date.to_datetime.to_f * 1000
      row << days_to_miliseconds(task.duration)
      task.percent_complete.nil? ? row << 0 : row << task.percent_complete
      dependencies = []
      task.dependencies.each do |d|
        dependencies << d.id
      end
      row << dependencies.join(', ')
      @rows << row
    end
    return @rows
  end

  def self.generate_master_rows
    rows = []
    tasks = Task.all
    tasks.each do |task|
      row = []
      row << task.id.to_s
      row << task.name
      row << task.project.name
      row << task.start_date.to_datetime.to_f * 1000
      row << task.end_date.to_datetime.to_f * 1000
      row << task.duration * 24 * 60 * 60 * 1000
      task.percent_complete.nil? ? row << 0 : row << task.percent_complete
      dependencies = []
      task.dependencies.each do |d|
        dependencies << d.id
      end
      row << dependencies.join(', ')
      rows << row
    end
    return rows
  end

end

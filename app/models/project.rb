class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }
  has_many :progress_notes

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

  def generate_gantt_chart_rows
    @rows = []
    self.tasks.each do |task|
      row = []
      row << task.id.to_s
      row << task.name
      row << task.start_date.to_datetime.to_f * 1000
      row << task.end_date.to_datetime.to_f * 1000
      row << task.duration
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

end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }
  has_many :progress_notes

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

  def generate_gantt_chart
    data_table = GoogleVisualr::DataTable.new
    
    data_table.new_column('string', 'Task ID')
    data_table.new_column('string', 'Task Name')
    data_table.new_column('date', 'Start Date')
    data_table.new_column('date', 'End Date')
    data_table.new_column('number', 'Duration')
    data_table.new_column('number', 'Percent Complete')
    data_table.new_column('string', 'Dependencies')

    rows = []
    self.tasks.each do |task|
      row = []
      row << task.name
      row << task.description
      row << task.start_date
      row << task.end_date
      row << task.duration
      row << task.percent_complete
      row << task.percent_complete
    end
  end

end

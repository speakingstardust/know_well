class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }
  has_many :progress_notes

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

  def days_to_milli(days)
    days * 24 * 60 * 60 * 1000
  end

  def generate_gantt_chart_data_table
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
      row << task.id.to_s
      row << task.name
      row << task.start_date
      row << task.end_date
      row << days_to_milli(task.duration)
      if task.percent_complete.nil?
        row << 0
      else
        row << task.percent_complete
      end
      dependencies = []
      task.dependencies.each do |d|
        dependencies << d.id
      end
      row << dependencies.join(', ')
      rows << row
    end

    data_table.add_rows(rows)
    return data_table
  end

end

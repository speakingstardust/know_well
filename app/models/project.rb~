class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :project_notes

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

end

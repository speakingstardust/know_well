class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :progress_notes
  accepts_nested_attributes_for :progress_notes, dependent: :destroy

  validates :name, presence: true

  enum status: [:active, :urgent, :low, :suspended, :canceled, :completed]
  enum department: [:lab, :sales, :it, :production]

end

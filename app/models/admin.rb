class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable
  
  has_many :projects
  has_many :expense_reports
  has_many :document_mail_logs

  def is_admin?
    true
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end

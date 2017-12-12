class User < ActiveRecord::Base
  rolify
  # has_and_belongs_to_many :roles, join_table: :users_roles
  accepts_nested_attributes_for :roles, allow_destroy: true, reject_if: :all_blank

  has_many :projects
  has_many :expense_reports
  has_many :document_mail_logs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def is_admin?
    false
  end

end

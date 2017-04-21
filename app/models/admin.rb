class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable
  
  has_many :projects

  def is_admin?
    true
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end

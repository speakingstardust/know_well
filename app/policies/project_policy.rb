class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user 
    @project = project
  end

  def edit?
    user.is_admin? or @project.user == user
  end

  def update?
    edit?
  end

  def destroy?
    user.is_admin? or @project.user == user
  end

  def master_gantt?
    user.is_admin?
  end
end

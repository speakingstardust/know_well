class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user 
    @project = project
  end

  def show?
    user.is_admin? or @project.user == user 
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

  class Scope < Scope
    def resolve 
      if user.is_admin? 
        scope.all
      else 
        scope.where(user: user)
     end
    end
  end
end

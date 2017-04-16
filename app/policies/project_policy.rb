class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user 
    @project = project
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

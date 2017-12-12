class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, expense_report)
    @user = user
    @document = document
  end

  def new?
    user.is_admin? or user.has_role? :lab_supervisor
  end

  def create?
    new?
  end
  
  def show?
    new?
  end

  def edit?
    new?
  end

  def update? 
    new?
  end

  def destroy?
    new?
  end

  class Scope < Scope
    def resolve
      if user.try(:has_role?, :lab_supervisor)
        scope.all
      else
        scope.where(current_version: true)
      end
    end
  end
end

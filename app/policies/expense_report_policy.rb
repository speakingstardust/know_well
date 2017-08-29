class ExpenseReportPolicy < ApplicationPolicy
  attr_reader :user, :expense_report

  def initialize(user, expense_report)
    @user = user 
    @expense_report = expense_report
  end

  def new? 
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :expense_report
  end

  def create? 
    new?
  end

  def show? 
    user.is_admin? or user.has_role? :bookkeeper or @expense_report.user == user 
  end

  def edit?
    user.is_admin? or user.has_role? :bookkeeper or @expense_report.user == user 
  end

  def update?
    edit?
  end

  def destroy? 
    user.is_admin? or user.has_role? :bookkeeper or @expense_report.user == user
  end

  class Scope < Scope
    def resolve
      if user.is_admin? or user.has_role? :bookkeeper
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end

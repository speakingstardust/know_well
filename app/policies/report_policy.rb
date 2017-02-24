class ReportPolicy < ApplicationPolicy
  attr_reader :user, :report

  def initialize(user, report)
    @user = user 
    @report = report
  end

  def index?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def show?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def new?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def create?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def edit?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def update?
    user.is_admin? or user.has_role? :bookkeeper
  end

  def destroy?
    user.is_admin? or user.has_role? :bookkeeper
  end
end

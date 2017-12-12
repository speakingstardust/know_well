class MeicoProductPolicy < ApplicationPolicy
  attr_reader :user, :meico_product

  def initialize(user, meico_product)
    @user = user 
    @meico_product = meico_product
  end

  def new?
    user.is_admin? or user.has_role? :lab_supervisor
  end

  def show?
    new?
  end

  def create?
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
end

class CustomerPolicy < ApplicationPolicy
  attr_reader :user, :customer

  def initialize(user, customer)
    @user = user
    @customer = customer 
  end

  def edit?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def new?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def create?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def update?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def destroy?
    user.is_admin?   
  end
end

class JigPolicy < ApplicationPolicy
  attr_reader :user, :jig

  def initialize(user, jig)
    @user = user
    @jig = jig
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

  def edit?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def destroy?
    user.is_admin? or user.has_role? :shop_supervisor
  end

  def show?
    user.is_admin? or user.has_role? :shop_supervisor or user.has_role? :shop_tech or user.has_role? :bookkeeper or user.has_role? :driver
  end
end

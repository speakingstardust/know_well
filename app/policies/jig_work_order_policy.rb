class JigWorkOrderPolicy < ApplicationPolicy
  attr_reader :user, :jig_work_order

  def initialize(user, jig_work_order)
    @user = user 
    @jig_work_order = jig_work_order
  end

  def index?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def show?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def print?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def packing_slip?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def new?
    user.is_admin? or user.has_role? :bookkeeper 
  end

  def create?
    user.is_admin? or user.has_role? :bookkeeper 
  end

  def edit?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def update?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def destroy?
    user.is_admin? or user.has_role? :bookkeeper 
  end

  def receive?
    user.is_admin? or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def ship?
    user.is_admin? or user.has_role? :shop_supervisor or user.has_role? :driver
  end

  def verify_completed?
    user.is_admin? or user.has_role? :shop_supervisor or user.has_role? :bookkeeper
  end

  def complete?
    user.is_admin? or user.has_role? :bookkeeper or user.has_role? :bookkeeper
  end

  def archive?
    user.is_admin? 
  end
end

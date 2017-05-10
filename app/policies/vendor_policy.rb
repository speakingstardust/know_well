class VendorPolicy < ApplicationPolicy
  attr_reader :user, :vendor

  def initialize(user, vendor)
    @user = user 
    @vendor = vendor
  end

  def new? 
    user.is_admin? or user.has_role? :shop_supervisor or user.has_role? :inventory_control
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

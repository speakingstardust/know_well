class ContactPolicy < ApplicationPolicy
  attr_reader :user, :contact

  def initialize(user, contact)
    @user = user
    @document = document
  end

  def new? 
    user.is_admin? or user.has_role? :bookkeeper
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
end

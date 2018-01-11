class DocumentMailLogPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, document_mail_log)
    @user = user
    @document_mail_log = document_mail_log
  end

  def new? 
    user.is_admin? or user.has_role? :lab_supervisor or user.has_role? :bookkeeper
  end

  def create?
    new?
  end
end

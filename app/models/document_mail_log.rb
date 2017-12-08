class DocumentMailLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :customer
end

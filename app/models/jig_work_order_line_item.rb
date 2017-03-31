class JigWorkOrderLineItem < ActiveRecord::Base
  belongs_to :jig
  belongs_to :jig_work_order

  validates :jig_id, presence: true
end

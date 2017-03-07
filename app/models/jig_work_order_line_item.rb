class JigWorkOrderLineItem < ActiveRecord::Base
  has_one :jig
  belongs_to :jig_work_order

  validates :jig_id, presence: true
end

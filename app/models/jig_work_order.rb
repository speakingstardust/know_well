class JigWorkOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :jig_work_order_line_items, :dependent => :destroy
  has_many :jigs, through: :jig_work_order_line_items

  accepts_nested_attributes_for :jig_work_order_line_items, :reject_if => lambda { |a| a[:jig_id].blank? }, :allow_destroy => true

  before_save :set_purchase_order

  validates :pickup_date, presence: true
  

  def set_purchase_order
    time = Time.now.strftime("%m%d%y-%H%M")
    if self.purchase_order == ''
      self.purchase_order = time
    end
  end
end

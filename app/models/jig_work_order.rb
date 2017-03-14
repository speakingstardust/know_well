class JigWorkOrder < ActiveRecord::Base
  include AASM

  belongs_to :customer
  has_many :jig_work_order_line_items, :dependent => :destroy
  has_many :jigs, through: :jig_work_order_line_items
  has_and_belongs_to_many :reports

  accepts_nested_attributes_for :jig_work_order_line_items, :reject_if => lambda { |a| a[:jig_id].blank? }, :allow_destroy => true

  before_save :set_purchase_order

  validates :pickup_date, presence: true
  
  aasm :whiny_transitions => false do
    state :created, :initial => true 
    state :opened
    state :received
    state :shipped 
    state :verified
    state :completed

    event :open, :after => :notify_supervisor do 
      transitions :from => :created, :to => :opened
    end

    event :receive do 
      transitions :from => :opened, :to => :received
    end

    event :ship do
      transitions :from => :received, :to => :shipped do
        guard do
          ready_for_shipping?
        end
      end
    end
    
    event :verify_completed, :after => :verification_info do
      transitions :from => :shipped, :to => :verified
    end
    
    event :complete do
      transitions :from => :verified, :to => :completed
    end
  end

  def notify_supervisor
    user = User.with_role(:shop_supervisor).first
    JigWorkOrderMailer.jig_work_order_created(user, self).deliver_now
  end

  def ready_for_shipping?
    if self.jig_work_order_line_items.map { |line_item| line_item.actual.nil? }.include?(true)
      return false
    end
    if self.returned.nil?
      return false
    end
    return true
  end

  def verification_info(pundit_user)
    self.verified_at = Time.now
    self.verified_by = "#{pundit_user.first_name} #{pundit_user.last_name}"
  end

  def set_purchase_order
    time = Time.now.strftime("%m%d%y-%H%M")
    if self.purchase_order == ''
      self.purchase_order = time
    end
  end
end

require 'pry'
class JigWorkOrder < ActiveRecord::Base
  include AASM

  belongs_to :customer
  has_many :jig_work_order_line_items, :dependent => :destroy
  has_many :jigs, through: :jig_work_order_line_items
  has_and_belongs_to_many :reports
  has_many :signatures, :dependent => :destroy

  accepts_nested_attributes_for :signatures, :reject_if => lambda { |a| a[:signature].blank? },:allow_destroy => true

  accepts_nested_attributes_for :jig_work_order_line_items, :reject_if => lambda { |a| a[:jig_id].blank? }, :allow_destroy => true

  validates :pickup_date, presence: true

  scope :completed_before, ->(datetime) { where("completed_at < ?", datetime) } 
  
  aasm :whiny_transitions => false do
    state :created, :initial => true 
    state :opened
    state :received
    state :shipped 
    state :verified
    state :completed
    state :archived

    event :open, :after => :notify_supervisor do 
      transitions :from => :created, :to => :opened
    end

    event :receive do 
      transitions :from => :opened, :to => :received
    end

    event :ship, :after => :notify_shipped do
      transitions :from => :received, :to => :shipped do
        guard do
          ready_for_shipping?
        end
      end
    end
    
    event :verify_completed, :after => :verification_info_and_notification do
      transitions :from => :shipped, :to => :verified
    end
    
    event :complete, :after => :completed_info do
      transitions :from => :verified, :to => :completed
    end

    event :archive do 
      transitions :from => :completed, :to => :archived
    end
  end

  def notify_supervisor
    user = User.with_role(:shop_supervisor)
    user.each do |user|
      JigWorkOrderMailer.jig_work_order_created(user, self).deliver_now
    end
  end

  def ready_for_shipping?
    if self.jig_work_order_line_items.map { |line_item| line_item.actual.nil? }.include?(true)
      return false
    end
    if self.returned.nil?
      return false
    end
    if self.driver.nil?
      return false
    end
    if self.truck_number.nil?
      return false
    end
    return true
  end

  def notify_shipped
    admins = Admin.all
    admins.each do |admin|
      JigWorkOrderMailer.jig_work_order_shipped(admin, self).deliver_now
    end
    bookkeepers = User.with_role(:bookkeeper)
    bookkeepers.each do |bookkeeper|
      JigWorkOrderMailer.jig_work_order_shipped(bookkeeper, self).deliver_now
    end
    if self.customer.name == "Toyoda Gosei"
      JigWorkOrderMailer.jig_work_order_shipped_to_gosei("joel@autochemky.com", self).deliver_now
      JigWorkOrderMailer.jig_work_order_shipped_to_gosei("angela.brock@toyodagosei.com", self).deliver_now
      JigWorkOrderMailer.jig_work_order_shipped_to_gosei("angela.brock@tgky.com", self).deliver_now
    end
  end

  def verification_info_and_notification(pundit_user)
    self.verified_at = Time.now
    self.verified_by = "#{pundit_user.first_name} #{pundit_user.last_name}"
    admins = Admin.all
    admins.each do |admin|
      JigWorkOrderMailer.jig_work_order_verified(admin, self).deliver_now
    end
    bookkeepers = User.with_role(:bookkeeper)
    bookkeepers.each do |bookkeeper|
      JigWorkOrderMailer.jig_work_order_verified(bookkeeper, self).deliver_now
    end
  end

  def completed_info(pundit_user)
    self.completed_at = Time.now
    self.completed_by = "#{pundit_user.first_name} #{pundit_user.last_name}"
  end

  def self.archive_old_orders
    old_work_orders = JigWorkOrder.completed_before(DateTime.now - 60)
    old_work_orders.each do |work_order|
      work_order.archive!
    end
  end

  def self.create_daily_jig_work_orders
    customer_names = ["Toyoda Gosei", "Dr. Schneider Automotive Systems, Inc."]
    customers = customer_names.map {|name| Customer.find_by_name(name) }
    customers.each do |customer|
      create_jig_work_order(customer)
      create_jig_work_order(customer)
    end
  end

  def self.create_jig_work_order(customer)
    jig = Jig.where(customer: customer).first
    date = Date.today
    work_order = JigWorkOrder.create(customer: customer, pickup_date: date)
    work_order.jig_work_order_line_items.create(jig: jig, expected: 0)
    work_order.save
    work_order.open!
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |jig_work_order|
        csv << jig_work_order.attributes.values_at(*column_names)
      end
    end 
  end
end

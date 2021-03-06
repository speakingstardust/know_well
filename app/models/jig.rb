class Jig < ActiveRecord::Base
  belongs_to :customer
  has_many :jig_work_order_line_items 
  has_many :jig_work_orders, through: :jig_work_order_line_items
  has_many :jig_order_line_items
  has_many :jig_orders, through: :jig_order_line_items
  has_many :report_line_items
  before_save :set_prices
  after_create :notify_admins

  validates :name, presence: true
  validates :customer, presence: true

  default_scope { order(name: :asc) }

  has_attached_file :jig_photo,
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

  validates_attachment_content_type :jig_photo, :content_type => /\Aimage\/.*\Z/

  def set_prices
    self.cleaning_charge ||= 0.0
    self.repair_charge ||= 0.0
  end

  def notify_admins
    admins = Admin.all
    admins.each do |admin|
      JigMailer.new_jig_created(admin, self).deliver_now
    end
  end
end

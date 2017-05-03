class Order < ActiveRecord::Base
  has_many :order_line_items, dependent: :destroy
  has_many :products, through: :order_line_items

  before_save :set_date_created

  time_for_a_boolean :completed


  def set_date_created
    self.date_created = Date.today
  end
end

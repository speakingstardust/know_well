require 'pry'
class Order < ActiveRecord::Base
  has_many :order_line_items, dependent: :destroy
  has_many :products, through: :order_line_items

  before_save :set_date_created
  after_touch :check_and_set_completed_at

  time_for_a_boolean :completed


  def set_date_created
    self.date_created = Date.today
  end

  def check_and_set_completed_at
    result = []
    self.order_line_items.each do |li|
      if li.received? == false or li.received? == nil
        result << false
      elsif li.received? == true
        result << true
      end
    end
    if result.uniq.include?(false)
      self.completed = false
    else
      self.completed = true
    end
  end 
end

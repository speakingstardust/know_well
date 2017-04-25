class Vendor < ActiveRecord::Base
  before_save :format_phone

  validates :name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :website, presence: true

  def format_phone
    self.phone.gsub!(/\D/, '')
  end

end

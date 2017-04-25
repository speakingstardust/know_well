class Manufacturer < ActiveRecord::Base
  before_save :format_phone

  validates :name, presence: true, uniqueness: true

  def format_phone
    self.phone.gsub!(/\D/, '')
  end

end

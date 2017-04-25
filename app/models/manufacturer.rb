class Manufacturer < ActiveRecord::Base
  before_save :format_phone

  validates :name, presence: true, uniqueness: true

  def format_phone
    unless self.phone == nil
      self.phone.gsub!(/\D/, '')
    end
  end

end

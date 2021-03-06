require 'base64'
require 'pry'
class Signature < ActiveRecord::Base
  HEIGHT = 160
  WIDTH = 480

  belongs_to :jig_work_order

  before_save :generate_image
  has_attached_file :image, 
    styles: {
      thumb: '100x100>',
      full: '400x700>'
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  private
    def generate_image
      data_uri = self.signature
      encoded_image = data_uri.split(",")[1]
      decoded_image = Base64.decode64(encoded_image)
      file_path = Rails.root.join("tmp/#{self.id}.png").to_s
      File.open(file_path, "wb") { |f| f.write(decoded_image) }
      file = File.open(file_path)
      self.image = file
    end
end

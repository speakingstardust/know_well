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
      instructions = JSON.parse(signature).map { |h| "line #{h['mx'].to_i},#{h['my'].to_i} #{h['lx'].to_i},#{h['ly'].to_i}" } * ' '
      image = StringIO.new
      Open3.popen3("convert -size #{WIDTH}x#{HEIGHT} xc:transparent -stroke blue -draw @- PNG:-") do |input, output, error|
        input.puts instructions
        input.close
        image.puts(output.read)
      end
      self.image = image
    end
end

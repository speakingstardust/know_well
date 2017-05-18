require 'pry'

class CreatesProductReport
  attr_accessor :categories, :product_report, :notes

  def initialize(categories, notes)
    @categories = categories
    @notes = notes
  end

  def build
    self.product_report = ProductReport.new(notes: @notes, categories: @categories)
    product_report.find_products
    product_report.save_line_items
  end

  def create
    build
    product_report.save
  end
end

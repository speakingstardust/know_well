require 'pry'

class CreatesProductReport
  attr_accessor :categories, :product_report

  def initialize(categories)
    @categories = categories
  end

  def build
    self.product_report = ProductReport.new
    product_report.find_products(@categories)
    product_report.create_line_items(product_report.products)
  end
end

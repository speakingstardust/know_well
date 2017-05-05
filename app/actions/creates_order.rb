class CreatesOrder
  attr_accessor :products, :order

  def initialize(products)
    @products = products
  end

  def build
    self.order = Order.new
    order.create_line_items(@products)
  end
end

class CreatesOrder
  attr_accessor :products

  def initialize(products)
    @products = products
  end

  def build
    self.order = Order.new
  end
end

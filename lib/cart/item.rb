
module Cart
  class Item
    attr_accessor :product, :quantity, :price

    def initialize(product, quantity, price=nil)
      @product = product
      @quantity = quantity
      @price = price
    end

  end
end

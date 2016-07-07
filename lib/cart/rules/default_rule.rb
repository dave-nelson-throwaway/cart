
module Cart
  module Rules
    class DefaultRule
      def initialize(products)
        @products = products
      end

      def does_apply?(cart_item, month=nil)
        @products.exists? cart_item.product
      end
  
      def bill_items(cart_item)
        [ Cart::Item.new(cart_item.product, cart_item.quantity,
                         cart_item.quantity * @products.price(cart_item.product)) ]
      end

    end
  end
end

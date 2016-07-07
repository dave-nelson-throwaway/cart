module Cart
  module Rules

    # Rule: bundle items (i.e. buy one get another too)
    class BundleItem

      def initialize(products, item_product, free_product)
        @products = products
        @item_product = item_product
        @free_product = free_product
      end

      def does_apply?(cart_item, month=nil)
        @products.exists?(cart_item.product) && 
          @item_product.eql?(cart_item.product)
      end

      def bill_items(cart_item)
        [ Cart::Item.new(cart_item.product, cart_item.quantity, 
                         cart_item.quantity * @products.price(cart_item.product)),
          Cart::Item.new(@free_product, cart_item.quantity, 0.0),
        ]
      end

    end
  end
end

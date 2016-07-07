
module Cart
  module Rules

    # Rule: buy X get Y free.
    #
    # Returns a single item with the same quantity but priced at a lower rate 
    # (e.g. 3 for 2).
    class BuySomeGetSomeFree

      def initialize(products, code, bonus_qty, discount_qty)
        @products = products
        @code = code
        @bonus_qty = bonus_qty
        @discount_qty = discount_qty
      end

      def does_apply?(cart_item, month=nil)
        @code.eql?(cart_item.product) && cart_item.quantity >= @bonus_qty
      end

      def bill_items(cart_item)
        bill_qty = (cart_item.quantity / @bonus_qty * @discount_qty) + 
          (cart_item.quantity % @bonus_qty)
        [ Cart::Item.new(cart_item.product, cart_item.quantity,
                                 bill_qty * @products.price(cart_item.product)) ]
      end

    end
  end
end

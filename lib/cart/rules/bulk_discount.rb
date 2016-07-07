module Cart
  module Rules

    # Rule: get a lower price for volume.
    class BulkDiscount

      def initialize(code, bonus_qty, discount_rate, month_limit=nil)
        @code = code
        @bonus_qty = bonus_qty
        @discount_rate = discount_rate
        @month_limit = month_limit
      end

      def does_apply?(cart_item, month=nil)
        @code.eql?(cart_item.product) && @bonus_qty <= cart_item.quantity &&
          (@month_limit == nil || (month && month < @month_limit))
      end

      def bill_items(cart_item)
        [ Cart::Item.new(cart_item.product, cart_item.quantity, 
                         cart_item.quantity * @discount_rate) ]
      end

    end
  end
end

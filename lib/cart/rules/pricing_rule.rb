
module Cart
  module Rules

    # Decorator encapsulating a pricing rule.
    class PricingRule

      def initialize(rule)
        @rule = rule
      end

      def does_apply?(cart_item, month=nil)
        @rule.does_apply?(cart_item, month)
      end

      def bill_items(cart_item, month=nil)
        @rule.does_apply?(cart_item, month) ? @rule.bill_items(cart_item) : []
      end
          
    end
  end
end

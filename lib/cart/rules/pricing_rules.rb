module Cart
  module Rules

    # Uses the product list and pricing rules (discounts etc.) to generate bill 
    # items from cart items.
    class PricingRules
      include Cart::Config::Rules

      attr_accessor :products, :promos, :rules

      def initialize(products=nil, promos=nil)
        @products = products || Cart::Config::Products.new
        @promos = promos || Cart::Config::Promos.new
        @rules = define_rules(@products)
      end

      # Finds the first pricing rule that applies and returns items generated 
      # from it; else returns empty [].
      def bill_items(cart_item, month=nil)
        @rules.each do |rule|
          if rule.does_apply?(cart_item, month)
            return rule.bill_items(cart_item, month)
          end
        end
        []
      end

      def promo_rate(code)
        @promos.rate(code)
      end

    end
  end
end

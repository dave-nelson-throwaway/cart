module Cart
  module Config
    
    # This module is intended as a mix-in to provide pricing rules to a class.
    #
    # This is where you edit the pricing rules.  The last rule is the default
    # (the listed price) which should be applied if no other rule matches.
    module Rules

      def define_rules(products=nil)
        products ||= Cart::Config::Products.new
        [
          # 3 for 2 rule on Unlimited 1GB sims
          Cart::Rules::PricingRule.new(
            Cart::Rules::BuySomeGetSomeFree.new(products, 'ult_small', 3, 2)
          ),

          # Bulk discount on Unlimited 5GB sims: $39.90 
          # for the first month if more than 3 ordered
          Cart::Rules::PricingRule.new(
            Cart::Rules::BulkDiscount.new('ult_large', 3, 39.9)
          ),

          # Bundle a free 1GB Data-pack with every Unlimited 2GB sold
          Cart::Rules::PricingRule.new(
            Cart::Rules::BundleItem.new(products, 'ult_medium', '1gb')
          ),

          # (Default: listed price)
          Cart::Rules::PricingRule.new(Cart::Rules::DefaultRule.new(products)),
        ]
      end

    end
  end
end

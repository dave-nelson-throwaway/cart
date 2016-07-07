module Cart

  # The shopping cart is a container to which items can be added.  A list of 
  # billable items can be retrieved, along with the bill total (including promo 
  # code discount if applicable).
  class ShoppingCart
    DECIMAL_PLACES=2

    attr_accessor :cart_items

    def initialize(pricing_rules, month=nil)
      @pricing_rules = pricing_rules
      @month = month
      @cart_items = {}
      @bill_items = nil
      @promo_code = nil
    end

    # Add to cart items, aggregating multiple additions of the same item type.
    # Also sets the cart promo code (if specified).
    def add(item, promo_code=nil)
      @promo_code = promo_code || @promo_code  # only set if present
      reset_bill_items!
      if @cart_items.has_key?(item.product)
        @cart_items[item.product].quantity += item.quantity
      else
        @cart_items[item.product] = item.clone
      end
    end

    def items
      create_bill_items!
      return @bill_items
    end

    def total
      create_bill_items!
      total_price = 0
      @bill_items.each do | product, bill_item |
        total_price += bill_item.price
      end
      return apply_promo(total_price).round(DECIMAL_PLACES)
    end

    private

    def reset_bill_items!
      @bill_items = nil
    end

    # Create bill items from all the items in the cart, using the pricing rules
    def create_bill_items!
      return @bill_items if @bill_items
      @bill_items = {}
      @cart_items.each do |product, cart_item|
        @pricing_rules.bill_items(cart_item, @month).each do |bill_item|
          if @bill_items.has_key?(bill_item.product)
            @bill_items[bill_item.product].quantity += bill_item.quantity
            @bill_items[bill_item.product].price += bill_item.price
          else
            @bill_items[bill_item.product] = bill_item.clone
          end
        end
      end
    end

    def apply_promo(total_price)
      total_price * @pricing_rules.promo_rate(@promo_code)
    end
  end
end

require_relative '../spec_helper'

describe Cart::ShoppingCart do

  context 'Shopping cart' do

    before :example do
      products = Cart::Config::Products.new(Cart::Fixtures::PRODUCTS_PATH)
      promos = Cart::Config::Promos.new(Cart::Fixtures::PROMOS_PATH)
      @cart = Cart::ShoppingCart.new(Cart::Rules::PricingRules.new(products, promos))
      @item = Cart::Item.new('ult_large', 1)
    end

    describe '#add' do
      it 'accepts a valid item' do
        @cart.add(@item)
        expect(@cart.cart_items.count).to eq(1)
      end
    end

    describe '#total' do
      it 'starts with a total of 0.0' do
        expect(@cart.total).to eq(0.0)
      end

      it 'has a total of added items' do
        @cart.add(@item)
        expect(@cart.total).to eq(44.90)
      end
    end

  end
end

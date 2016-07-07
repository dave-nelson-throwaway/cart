require_relative './spec_helper'

describe Cart do

  before :context do
    @products = Cart::Config::Products.new(Cart::Fixtures::PRODUCTS_PATH)
    @promos = Cart::Config::Promos.new(Cart::Fixtures::PROMOS_PATH)
  end

  # ### Scenario 1 ###
  # Items added:
  #  - 3 x Unlimited 1GB
  #  - 1 x Unlimited 5GB
  # Expected:
  #  - (same items)
  #  - Total: $94.70
  context 'Scenario 1' do

    before :example do
      @cart = Cart::ShoppingCart.new(Cart::Rules::PricingRules.new(@products, @promos))
      @cart.add(Cart::Item.new('ult_small', 3))
      @cart.add(Cart::Item.new('ult_large', 1))
    end

    describe '#total' do
      it 'should have a total cost of $94.70' do
        expect(@cart.total).to eq(94.7)
      end
    end

    describe '#items' do
      it 'should have two types of item...' do
        expect(@cart.items.size).to eq(2)
      end

      it 'consisting of three ult_small...' do
        expect(@cart.items['ult_small'].quantity).to eq(3)
      end

      it 'and one ult_large.' do
        expect(@cart.items['ult_large'].quantity).to eq(1)
      end
    end

  end

  # ### Scenario 2 ###
  # Items added:
  #  - 2 x Unlimited 1GB
  #  - 4 x Unlimited 5GB
  # Expected:
  #  - (same items)
  #  - Total: $209.40
  context 'Scenario 2' do

    before :example do
      @cart = Cart::ShoppingCart.new(Cart::Rules::PricingRules.new(@products, @promos))
      @cart.add(Cart::Item.new('ult_small', 2))
      @cart.add(Cart::Item.new('ult_large', 4))
    end

    describe '#total' do
      it 'should have a total cost of $209.40' do
        expect(@cart.total).to eq(209.4)
      end
    end

    describe '#items' do
      it 'should have two types of item...' do
        expect(@cart.items.size).to eq(2)
      end

      it 'consisting of two ult_small...' do
        expect(@cart.items['ult_small'].quantity).to eq(2)
      end

      it 'and four ult_large.' do
        expect(@cart.items['ult_large'].quantity).to eq(4)
      end
    end
  end
  
  # ### Scenario 3 ###
  # Items added:
  #  - 1 x Unlimited 1GB
  #  - 2 x Unlimited 2GB
  # Expected:
  #  - 1 x Unlimited 1GB
  #  - 2 x Unlimited 2GB
  #  - 2 x 1GB Data-pack (bonus)
  #  - Total: $84.70
  context 'Scenario 3' do

    before :example do
      @cart = Cart::ShoppingCart.new(Cart::Rules::PricingRules.new(@products, @promos))
      @cart.add(Cart::Item.new('ult_small' , 1))
      @cart.add(Cart::Item.new('ult_medium', 2))
    end

    describe '#total' do
      it 'should have a total cost of $84.70' do
        expect(@cart.total).to eq(84.70)
      end
    end

    describe '#items' do
      it 'should have three types of item...' do
        expect(@cart.items.size).to eq(3)
      end

      it 'consisting of one ult_small, ...' do
        expect(@cart.items['ult_small'].quantity).to eq(1)
      end

      it 'two ult_medium...' do
        expect(@cart.items['ult_medium'].quantity).to eq(2)
      end

      it 'and two bonus 1GB data packs' do
        expect(@cart.items['1gb'].quantity).to eq(2)
      end
    end
  end

  # ### Scenario 4 ###
  # Items added:
  #  - 1 x Unlimited 1GB
  #  - 1 x 1GB Data-pack
  # Promo applied
  # Expected:
  #  - (same items)
  #  - Total: $31.32 (incl. discount)
  context 'Scenario 4' do

    before :example do
      @cart = Cart::ShoppingCart.new(Cart::Rules::PricingRules.new(@products, @promos))
      @cart.add(Cart::Item.new('ult_small', 1))
      @cart.add(Cart::Item.new('1gb'      , 1), 'I<3AMAYSIM')
    end

    describe '#total' do
      it 'should have a total cost of $31.32 (discounted)' do
        expect(@cart.total).to eq(31.32)
      end
    end

    describe '#items' do
      it 'should have two types of item...' do
        expect(@cart.items.size).to eq(2)
      end

      it 'consisting of one ult_small...' do
        expect(@cart.items['ult_small'].quantity).to eq(1)
      end

      it 'and one 1gb.' do
        expect(@cart.items['1gb'].quantity).to eq(1)
      end
    end
  end
end

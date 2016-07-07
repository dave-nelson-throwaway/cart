require_relative '../../spec_helper'

describe Cart::Rules::PricingRules do

  before :context do
    @rules = Cart::Rules::PricingRules.new
  end

  context 'Pricing rules products' do

    describe '#products' do
      
      it 'has products defined' do
        expect(@rules.products).to be_truthy
      end

    end

    describe '#bill_items' do

      it 'creates bill items for a valid item' do
        expect(@rules.bill_items(Cart::Item.new('ult_large', 1)).length).to eq(1) 
      end
    end

  end

end

require_relative '../../spec_helper'

describe Cart::Rules::DefaultRule do

  before :context do
    @rule = Cart::Rules::DefaultRule.new(Cart::Config::Products.new)
  end

  context 'Default pricing rule applies?' do

    describe '#does_apply?' do
      it 'does apply to item' do
        item = Cart::Item.new('ult_small', 3)
        expect(@rule.does_apply?(item)).to be_truthy
      end

      it 'does not apply to item' do
        item = Cart::Item.new('some other product', 1)
        expect(@rule.does_apply?(item)).to be_falsey
      end
    end

  end

  context 'Pricing rule generates bill items' do
    
    before :example do
      @item = Cart::Item.new('ult_small', 3)
    end

    describe '#bill_items' do
      it 'generates a single output bill item' do
        expect(@rule.bill_items(@item).length).to eq(1)
      end

      it 'generates an item with correct price' do
        expect(@rule.bill_items(@item).first.price).to eq(3 * 24.90)
      end

      it 'generates an item with the same quantity' do
        expect(@rule.bill_items(@item).first.quantity).to eq(3)
      end
    end
    
  end

end

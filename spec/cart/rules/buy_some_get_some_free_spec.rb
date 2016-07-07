require_relative '../../spec_helper'

describe Cart::Rules::BuySomeGetSomeFree do
  
  before :context do
    @rule = Cart::Rules::BuySomeGetSomeFree.new(Cart::Config::Products.new,
                                                'ult_large', 3, 2)
  end

  context 'Buy some get some free rule' do
    before :example do
      @item = Cart::Item.new('ult_large', 3)
    end

    describe '#does_apply?' do
      it 'applies to 3 items' do
        expect(@rule.does_apply?(@item)).to be_truthy
      end

      it 'does not apply to less than 3 items' do
        @item.quantity = 2
        expect(@rule.does_apply?(@item)).to be_falsey
      end

      it 'does not apply to other types of item' do
        @item.product = 'other product'
        expect(@rule.does_apply?(@item)).to be_falsey
      end
    end

    describe '#bill_items' do
      it 'Does not change the billed quantity' do
        expect(@rule.bill_items(@item).first.quantity).to eq(3)
      end

      it 'Bills at the discounted quantity' do
        expect(@rule.bill_items(@item).first.price).to eq(44.90 * 2)
      end
    end
  end
end

require_relative '../../spec_helper'

describe Cart::Rules::BulkDiscount do

  before :context do
    @rule = Cart::Rules::BulkDiscount.new('ult_large', 3, 39.9)
  end

  context 'Bulk discount rule' do
    before :example do
      @item = Cart::Item.new('ult_large', 3)
    end

    describe '#does_apply?' do
      it 'applies to 3 or more items' do
        expect(@rule.does_apply?(@item)).to be_truthy
      end

      it 'doesn''t apply to less than 3 items' do
        @item.quantity = 2
        expect(@rule.does_apply?(@item)).to be_falsey
      end
    end

    describe '#bill_items' do
      it 'Applies the discounted price' do
        expect(@rule.bill_items(@item).first.price).to eq(39.9 * 3)
      end
    end
  end
end

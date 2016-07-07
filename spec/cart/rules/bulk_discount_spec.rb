require_relative '../../spec_helper'

describe Cart::Rules::BulkDiscount do

  context 'Bulk discount rule (no month)' do
    before :example do
      @rule = Cart::Rules::BulkDiscount.new('ult_large', 3, 39.9)
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

  context 'Bulk discount rule (first month only)' do
    before :example do
      @rule = Cart::Rules::BulkDiscount.new('ult_large', 3, 39.9, 1)
      @item = Cart::Item.new('ult_large', 3)
    end

    describe '#does_apply?' do
      it 'doesn''t apply if no month is specified' do
        expect(@rule.does_apply?(@item)).to be_falsey
      end

      it 'doesn''t apply if the month is later than the limit' do
        expect(@rule.does_apply?(@item, 1)).to be_falsey
      end

      it 'applies if the month is earlier than the limit' do
        expect(@rule.does_apply?(@item, 0)).to be_truthy
      end
    end
  end
end

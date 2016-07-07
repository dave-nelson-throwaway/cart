require_relative '../../spec_helper'

describe Cart::Rules::BundleItem do

  before :context do
    products = Cart::Config::Products.new(Cart::Fixtures::PRODUCTS_PATH)
    @rule = Cart::Rules::BundleItem.new(products, 'ult_medium', '1gb')
  end

  context 'Get item bundled with other item for free' do
    before :example do
      @item = Cart::Item.new('ult_medium', 1)
    end

    describe '#does_apply?' do
      it 'applies to products of the specified type' do
        expect(@rule.does_apply?(@item)).to be_truthy
      end

      it 'doesn''t apply to other types of product' do
        @item.product = 'other product'
        expect(@rule.does_apply?(@item)).to be_falsey
      end
    end

    describe '#bill_items' do
      it 'produces extra bonus items' do
        expect(@rule.bill_items(@item).length).to eq(2)
      end

      it 'provides the extra items for free' do
        expect(@rule.bill_items(@item).last.price).to eq(0.0)
      end
    end
  end
end

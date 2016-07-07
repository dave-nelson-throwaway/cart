require_relative '../spec_helper'

describe Cart::Item do
  context 'Shopping cart item' do
    before :each do
      @item = Cart::Item.new('test product', 3)
    end

    describe '#product' do
      it 'has the specified product' do
        expect(@item.product).to eq('test product')
      end
    end

    describe '#quantity' do
      it 'has the specified quantity' do
        expect(@item.quantity).to eq(3)
      end
    end

  end
end

require_relative '../../spec_helper'

describe Cart::Config::Products do

  before :context do
    @products = Cart::Config::Products.new(Cart::Fixtures::PRODUCTS_PATH)
  end

  context 'Products' do
    
    describe '#exists?' do
      it 'is true for a product that exists' do
        expect(@products.exists?('ult_small')).to be_truthy
      end

      it 'is false for a product that doesn''t exist' do
        expect(@products.exists?('unknown')).to be_falsey
      end
    end

    describe '#name' do
      it 'returns the name of a product given the product code' do
        expect(@products.name('ult_small')).to eql('Unlimited 1GB')
      end
    end

    describe '#price' do
      it 'returns the base price of a product given the product code' do
        expect(@products.price('ult_small')).to eql(24.9)
      end
    end
  end
end

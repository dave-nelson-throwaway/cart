require_relative '../../spec_helper'

describe Cart::Config::Promos do

  before :context do
    @promos = Cart::Config::Promos.new(Cart::Fixtures::PROMOS_PATH)
  end

  context 'Promotion codes' do

    describe '#rate' do

      it 'defaults to a rate of 1.0 (i.e. full price)' do
       expect(@promos.rate(nil)).to eq(1.0)
      end

      it 'gives the full rate of 1.0 for old/unknown codes' do
        expect(@promos.rate('unknown')).to eq(1.0)
      end

      it 'gives a discounted rate for a known code' do
        expect(@promos.rate('I<3AMAYSIM')).to eq(0.9)
      end

    end
  end
end

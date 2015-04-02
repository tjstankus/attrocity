require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe Coercers::Integer do
    subject(:coercer) { Coercers::Integer.new }

    describe '#coerce' do
      it 'coerces to an integer' do
        expect(coercer.coerce('1')).to eq(1)
      end

      describe 'given nil' do
        it 'returns nil' do
          expect(coercer.coerce(nil)).to be_nil
        end
      end

      describe 'given an empty string' do
        it 'returns nil' do
          expect(coercer.coerce('')).to be_nil
        end
      end
    end
  end
end

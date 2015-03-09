require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe Coercers::Integer do
    subject(:coercer) { Coercers::Integer.new }

    describe '#coerce' do
      it 'coerces to an integer' do
        expect(coercer.coerce('1')).to eq(1)
      end

      it 'raises coercion error for unsupported coercions' do
        ['', nil].each do |val|
          expect { coercer.coerce(val) }.to raise_error(Attrocity::CoercionError)
        end
      end
    end
  end
end

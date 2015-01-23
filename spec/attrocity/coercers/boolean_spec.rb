require 'attrocity/coercers/boolean'

module Attrocity
  RSpec.describe Coercers::Boolean do
    describe '#coerce' do
      let(:coercer) { Coercers::Boolean.new }

      it 'coerces "1" to true' do
        expect(coercer.coerce('1')).to be true
      end

      it 'coerces "0" to false' do
        expect(coercer.coerce('0')).to be false
      end

      it 'coerces 1 to true' do
        expect(coercer.coerce(1)).to be true
      end

      it 'coerces 0 to false' do
        expect(coercer.coerce(0)).to be false
      end

      it 'coerces true to true' do
        expect(coercer.coerce(true)).to be true
      end

      it 'coerces false to false' do
        expect(coercer.coerce(false)).to be false
      end
    end
  end
end


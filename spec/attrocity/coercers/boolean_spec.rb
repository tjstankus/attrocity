require 'attrocity/coercers/boolean'

module Attrocity
  RSpec.describe Coercers::Boolean do

    subject(:coercer) { Coercers::Boolean.new }

    describe '#coerce' do
      it 'coerces nil to false' do
        expect(coercer.coerce(nil)).to be false
      end

      it 'coerces false to false' do
        expect(coercer.coerce(false)).to be false
      end

      it 'coerces true to true' do
        expect(coercer.coerce(true)).to be true
      end

      it 'coerces 0 to true' do
        expect(coercer.coerce(0)).to be true
      end

      it 'coerces an object to true' do
        expect(coercer.coerce(Object.new)).to be true
      end
    end

  end
end


require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe Coercers::Integer do
    describe '#coerce' do
      it 'coerces to an integer' do
        coercer = Coercers::Integer.new
        expect(coercer.coerce('1')).to eq(1)
      end
    end
  end
end

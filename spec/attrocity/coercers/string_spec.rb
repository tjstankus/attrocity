require 'attrocity/coercers/string'

module Attrocity
  RSpec.describe Coercers::String do
    describe '#coerce' do
      it 'coerces to a string' do
        coercer = Coercers::String.new
        expect(coercer.coerce(1)).to eq('1')
      end
    end
  end
end


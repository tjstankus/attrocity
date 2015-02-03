require 'attrocity/attribute'
require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe Attribute do
    describe '.initialize' do
      it 'accepts parameters ...?'
    end

    describe '#deep_clone' do
      it 'might work, this is a placeholder'
    end

    describe '#value=' do
      it 'coerces value' do
        name = key = :age
        mapper = Attribute.default_mapper(key)
        attr = Attribute.new(name, Coercers::Integer.new, mapper)
        attr.value = '10'
        expect(attr.value).to eq(10)
      end
    end
  end
end

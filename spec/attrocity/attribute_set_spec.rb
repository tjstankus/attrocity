# TODO: Cleanup setup code in these specs
require 'support/examples'
require 'attrocity/attribute_set'
require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe AttributeSet do

    # TODO: Remove?
    describe '#[:name]' do
      let(:attribute) { Examples.string_attribute }
      let(:attribute_set) { AttributeSet.new(Array(attribute)) }

      it 'returns the value of the attribute with the given name' do
        pending
        attribute_set.set_value_for(attribute.name, 'bar')
        expect(attribute_set[:a_string]).to eq('bar')
      end
    end

    describe '#set_value_for' do
      it 'sets the value of the attribute with the given name'
    end

    describe '#to_h' do
      it 'returns a hash of attribute names and values'
    end

    describe '#<<' do
      subject { described_class.new }

      it 'adds an attribute' do
        attr = double('attribute')
        subject << attr
        expect(subject.attributes).to include(attr)
      end

      it 'raises error when non-attribute is added'
    end

  end
end

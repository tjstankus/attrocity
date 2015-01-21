require 'attrocity/attribute_set'

module Attrocity
  RSpec.describe AttributeSet do
    describe '#attribute_set' do
      it 'includes age attribute' do
        pending
        person = Examples::Person.new(age: 29)
        attribute_names = person.attribute_set.attributes.collect(&:name)
        expect(attribute_names).to include(:age)
      end
    end

    describe '#attributes' do
      it 'returns a hash of mapped attributes'
    end

    describe '#unmapped_attributes' do
      it 'returns a hash of raw attribute names to coerced values'
      it 'omits unnecessary data'
    end

    describe '#<<' do
      it 'adds an attribute' do
      end

      it 'raises error when non-attribute is added'
    end
  end
end

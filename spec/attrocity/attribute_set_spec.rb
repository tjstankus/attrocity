require 'support/examples'
require 'attrocity/attribute_set'

module Attrocity
  RSpec.describe AttributeSet do
    describe '#attribute_set' do
      it 'includes age attribute' do
        person = Examples::Person.new(age: 29)
        attribute_names = person.attribute_set.attributes.collect(&:name)
        expect(attribute_names).to include(:age)
      end
    end

    describe '#deep_clone' do
      before do
        @attrs = [Examples.integer_attribute, Examples.string_attribute]
        @attr_set = AttributeSet.new(@attrs)
        @attr_set_clone = @attr_set.deep_clone
      end

      it 'creates a new instance' do
        expect(@attr_set_clone).not_to equal(@attr_set)
      end

      it 'deep clones attributes' do
        expect(@attr_set_clone.attributes.first).not_to equal(
          @attr_set.attributes.first)
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

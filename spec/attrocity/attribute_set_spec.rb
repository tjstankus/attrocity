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
  end
end

require 'attrocity'
require 'support/examples'

module Attrocity
  RSpec.describe 'Attrocity module' do

    describe '.initialize' do
      it 'accepts a hash' do
        expect {
          Examples::Person.new(age: 29)
        }.not_to raise_error
      end
    end

    describe '.attribute' do
      it 'does not raise error with declarative attribute method' do
        expect {
          module Examples
            class Person
              include Attrocity
              attribute :age, :integer
            end
          end
        }.not_to raise_error
      end

      it 'returns an attribute'
    end

    describe '#attribute_set' do
      it 'contains expected attributes' do
        pending
        obj = Examples::Person.new(age: 29)
        attribute_names = obj.attribute_set.map(&:name)
        expect(attribute_names).to include(:age)
      end
    end

  end
end

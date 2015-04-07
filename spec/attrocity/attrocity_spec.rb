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

      let(:person) { Examples::Person.new(age: 29) }

      it 'creates a reader for instance-scope attribute set' do
        expect { person.attribute_set }.not_to raise_error
      end

      it 'creates a reader for attribute' do
        expect(person.respond_to?(:age)).to be true
      end

      # TODO: Move this spec to another unit?
      it 'returns correct value for reader method' do
        expect(person.age).to eq(29)
      end
    end

    describe '.attribute' do
      it 'does not raise error with declarative attribute method' do
        expect {
          module Examples
            class SpecialPerson
              include Attrocity.model
              attribute :foo, coercer: :integer
            end
          end
        }.not_to raise_error
      end

      it 'raises error when missing coercer keyword argument' do
        expect {
          module Examples
            class SpecialDog
              include Attrocity.model
              attribute :name
            end
          end
        }.to raise_error(ArgumentError)
      end

      it 'raises error when using coercer name that is not on the registry' do
        expect {
          module Examples
            class Person
              include Attrocity.model
              attribute :foo, coercer: :xyz
            end
          end
        }.to raise_error
      end
    end

    describe '#attribute_set' do
      it 'contains expected attributes' do
        pending
        obj = Examples::Person.new(age: 29)
        attribute_names = obj.attribute_set.map(&:name)
        expect(attribute_names).to include(:age)
      end
    end

    describe '.from_mapped_data' do
      it 'returns an instantiated model' do
        data = { street: '1234 Elm', zip: '27517' }
        address = Examples::Address.from_mapped_data(data)
        expect(address.street).to eq('1234 Elm')
        expect(address.zip).to eq('27517')
      end
    end
  end
end

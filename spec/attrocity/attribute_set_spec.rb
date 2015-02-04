# TODO: Cleanup setup code in these specs
require 'support/examples'
require 'attrocity/attribute_set'
require 'attrocity/coercers/integer'

module Attrocity
  RSpec.describe AttributeSet do

    describe '#[:name]' do
      let(:attribute) { Examples.string_attribute }
      let(:attribute_set) { AttributeSet.new(Array(attribute)) }

      it 'returns the value of the attribute with the given name' do
        attribute_set.set_value_for(attribute.name, 'bar')
        expect(attribute_set[:a_string]).to eq('bar')
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

    describe 'attribute access methods' do
      let(:attr_name) { :a_string }

      before do
        @attribute_set = AttributeSet.new(
          Array(Examples.string_attribute(attr_name)))
        @object = Object.new
        @attribute = @attribute_set.attribute_for_name(attr_name)
      end

      describe '#create_reader_on' do
        before do
          @attribute_set.set_value_for(attr_name, 'bar')
        end

        it 'creates a reader method for the attribute' do
          expect {
            @attribute_set.create_reader_on(@object, @attribute)
          }.to change { @object.respond_to?(attr_name) }.from(false).to(true)
        end

        it 'returns the attribute value from the created reader method' do
          @attribute_set.create_reader_on(@object, @attribute)
          expect(@object.send(attr_name)).to eq(@attribute.value)
        end
      end

      describe '#create_writer_on' do
        it 'creates a writer method for the attribute' do
          expect {
            @attribute_set.create_writer_on(@object, @attribute)
          }.to change { @object.respond_to?("#{attr_name}=") }.from(false).to(true)
        end

        it 'sets the attribute value' do
          @attribute_set.create_writer_on(@object, @attribute)
          @object.send("#{attr_name}=", 'foobar')
          expect(@attribute.value).to eq('foobar')
        end
      end

      describe '#create_predicate_on' do
        it 'creates a predicate method for the attribute' do
          expect {
            @attribute_set.create_predicate_on(@object, @attribute)
          }.to change { @object.respond_to?("#{attr_name}?") }.from(false).to(true)
        end

        it 'returns true if the attribute has a truthy value' do
          @attribute_set.set_value_for(attr_name, 'foo')
          @attribute_set.create_predicate_on(@object, @attribute)
          expect(@object.send("#{attr_name}?")).to be true
        end

        it 'returns false if the attribute has a falsy value' do
          @attribute_set.create_predicate_on(@object, @attribute)
          expect(@attribute).to receive(:value).and_return(nil)
          expect(@object.send("#{attr_name}?")).to be false
        end
      end
    end

    describe '#set_value_for' do
      it 'sets the value of the attribute with the given name'
    end

    describe '#to_h' do
      it 'returns a hash of attribute names and values'
    end

    describe '#unmapped_attributes' do
      it 'returns a hash of unmapped raw attribute names to coerced values'
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

    describe '#set_values' do
      let(:mapper) { Attribute.default_mapper(:age) }
      let(:attr) { Attribute.new(:age, Coercers::Integer.new, mapper) }
      let(:attr_set) { AttributeSet.new([attr]) }
      let(:object) { double('object') }

      it 'sets attribute values' do
        attr_set.set_values(object, { age: 10 })
        expect(attr.value).to eq(10)
      end

      it 'sets attribute values via indifferent hash keys' do
        attr_set.set_values(object, { 'age' => 10 })
        expect(attr.value).to eq(10)
      end
    end

  end
end

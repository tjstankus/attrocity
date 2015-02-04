require 'spec_helper'

module Attrocity
  describe AttributeMethodsBuilder do
    let(:object) { Object.new }
    let(:attr_name) { :a_string }
    let(:attribute) { Examples.string_attribute(attr_name) }
    subject { AttributeMethodsBuilder.new(object, Array(attribute)) }

    describe '#define_reader' do
      it 'creates a reader method for the attribute' do
        expect {
          subject.define_reader(attribute)
        }.to change { object.respond_to?(attr_name) }.from(false).to(true)
      end

      it 'returns the attribute value from the created reader method' do
        subject.define_reader(attribute)
        attribute.value = 'foo'
        expect(object.send(attr_name)).to eq('foo')
      end
    end

    describe '#create_writer_on' do
      it 'creates a writer method for the attribute' do
        expect {
          subject.define_writer(attribute)
        }.to change { object.respond_to?("#{attr_name}=") }.from(false).to(true)
      end

      it 'sets the attribute value' do
        subject.define_writer(attribute)
        object.send("#{attr_name}=", 'foobar')
        expect(attribute.value).to eq('foobar')
      end
    end

    describe '#create_predicate_on' do
      it 'creates a predicate method for the attribute' do
        expect {
          subject.define_predicate(attribute)
        }.to change { object.respond_to?("#{attr_name}?") }.from(false).to(true)
      end

      it 'returns true if the attribute has a truthy value' do
        subject.define_predicate(attribute)
        attribute.value = 'xyz'
        expect(object.send("#{attr_name}?")).to be true
      end

      it 'returns false if the attribute has a falsy value' do
        subject.define_predicate(attribute)
        expect(attribute).to receive(:value).and_return(nil)
        expect(object.send("#{attr_name}?")).to be false
      end
    end
  end
end

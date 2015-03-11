module Attrocity
  RSpec.describe InstanceAttributeSet do
    let(:attrs) {
      [InstanceAttribute.new(:foo, 1),
       InstanceAttribute.new(:bar, 2) ]
    }
    subject(:attribute_set) { described_class.new }

    describe '#<<' do
      it 'adds an attribute' do
        attr = attrs.first
        subject << attr
        expect(attribute_set.attributes).to include(attr)
      end

      it 'raises error when non-attribute is added'
    end

    describe '#to_h' do
      it 'returns hash of instance attribute names and values' do
        attrs.each { |attr| attribute_set << attr }
        expect(attribute_set.to_h).to eq({ foo: 1, bar: 2 })
      end
    end
  end
end

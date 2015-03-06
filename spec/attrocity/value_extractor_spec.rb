module Attrocity
  RSpec.describe ValueExtractor do

    let(:data) { { foo: 'bar' } }
    let(:mapper) { KeyMapper.new(:foo) }
    let(:coercer) { Coercers::String.new }
    let(:default_value) { nil }
    subject(:extractor) {
      ValueExtractor.new(data, mapper, coercer, default_value)
    }

    describe '#value' do
      it 'extracts value from hash' do
        expect(extractor.value).to eq('bar')
      end

      it 'returns default value when mapper returns nil' do
        allow(mapper).to receive(:call).and_return(nil)
        expect(extractor.value).to eq(default_value)
      end

      it 'returns default value when mapper raises error' do
        allow(mapper).to receive(:call).and_raise(StandardError)
        expect(extractor.value).to eq(default_value)
      end

      it 'skips coercion when mapper returns default value' do
        allow(mapper).to receive(:call).and_return(default_value)
        expect(coercer).not_to receive(:coerce)
        extractor.value
      end

      it 'coerces value' do
        allow(mapper).to receive(:call).and_return(1)
        expect(extractor.value).to eq('1')
      end
    end

  end
end

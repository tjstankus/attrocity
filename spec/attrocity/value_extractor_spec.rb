module Attrocity
  RSpec.describe ValueExtractor do

    let(:data) { { foo: 'bar' } }
    let(:mapper) { KeyMapper.new(:foo) }
    let(:coercer) { Coercers::String.new }
    subject(:extractor) {
      ValueExtractor.new(data, mapper: mapper, coercer: coercer)
    }

    describe '#value' do
      it 'extracts value from hash' do
        expect(extractor.value).to eq('bar')
      end

      it 'coerces value' do
        allow(mapper).to receive(:call).and_return(1)
        expect(extractor.value).to eq('1')
      end
    end

  end
end

module Attrocity
  RSpec.describe KeyMapper do
    let(:default_value) { nil }
    subject(:mapper) { KeyMapper.new(:foo, default_value) }

    it 'extracts data via hash key' do
      expect(mapper.call(double, { foo: 'bar' })).to eq('bar')
    end

    it 'returns default value when key absent' do
      expect(mapper.call(double, { biz: 'baz' })).to eq(default_value)
    end

    describe 'override default value' do
      let(:default_value) { true }

      it 'returns overridden value when key is absent' do
        expect(mapper.call(double, { biz: 'baz' })).to eq(default_value)
      end
    end
  end
end

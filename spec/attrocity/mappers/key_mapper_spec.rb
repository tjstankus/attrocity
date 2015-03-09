module Attrocity
  RSpec.describe KeyMapper do
    subject(:mapper) { KeyMapper.new(:foo) }

    it 'extracts data via hash key' do
      expect(mapper.call(double, { foo: 'bar' })).to eq('bar')
    end

    it 'returns nil when key absent' do
      expect(mapper.call(double, { biz: 'baz' })).to be_nil
    end
  end
end

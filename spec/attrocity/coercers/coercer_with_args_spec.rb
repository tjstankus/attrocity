module Attrocity
  RSpec.describe 'coercer with args' do
    it 'coerces correctly' do
      model = Examples::DepositRange.new({ depositlow: '0', deposithigh: '999999' })
      expect(model.low).to be_nil
      expect(model.high).to be_nil
    end
  end
end

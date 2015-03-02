module Attrocity
  RSpec.describe 'Default value' do
    before do
      module Examples
        class DefaultValueExample
          include Attrocity.model
          attribute :bool, coercer: :boolean, default: true
        end
      end
    end

    it 'defaults to default value' do
      example = Examples::DefaultValueExample.new
      expect(example.bool).to be true
    end

    it 'overrides default value' do
      pending
      example = Examples::DefaultValueExample.new(bool: false)
      expect(example.bool).to be false
    end
  end
end

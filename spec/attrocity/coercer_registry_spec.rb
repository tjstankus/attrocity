require 'attrocity/coercer_registry'
require 'support/examples'

module Attrocity
  RSpec.describe CoercerRegistry do
    it 'adds to the registry' do
      CoercerRegistry.register do
        add :example, Examples::ExampleCoercer
      end
      expect(CoercerRegistry.coercer_for(:example)).
        to eq(Examples::ExampleCoercer)
    end
  end
end

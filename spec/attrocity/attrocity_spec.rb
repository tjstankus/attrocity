require 'support/examples'

module Attrocity
  RSpec.describe 'Attrocity module' do
    describe '.attribute' do
      it 'does not raise error' do
        expect {
          Examples::Person.new(age: 29)
        }.not_to raise_error
      end
    end
  end
end

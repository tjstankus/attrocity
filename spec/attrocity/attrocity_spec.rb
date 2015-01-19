require 'support/examples'

module Attrocity
  RSpec.describe 'Attrocity module' do

    describe '.attribute' do
      it 'does not raise error' do
        pending
        expect {
          module Examples
            class Person
              attribute :age, :integer
            end
          end
        }.not_to raise_error
      end
    end
  end
end

module Attrocity
  RSpec.describe 'Attrocity.model' do
    describe '#model' do
      let(:person) { Examples::Person.new(age: 50) }
      let(:model) { person.model }

      it 'returns a read-only object' do
        expect(model.respond_to?(:age)).to be true
        expect(model.respond_to?(:age=)).to be false
      end

      it 'has correct value for attribute' do
        expect(model.age).to eq(50)
      end
    end
  end
end

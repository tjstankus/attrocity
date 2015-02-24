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

      it 'includes model attributes' do
        listing = Examples::Listing.new({ id: '1234', zip: '10101' })
        model = listing.model
        expect(model.address).not_to be_nil
      end
    end
  end
end

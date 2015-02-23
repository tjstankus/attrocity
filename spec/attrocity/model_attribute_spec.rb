module Attrocity
  RSpec.describe ModelAttribute do

    describe 'instantiated model attribute' do
      let(:listing) {
        Examples::Listing.new({ 'listingid' => '1234',
                                'addressline1' => '100 Elm Street',
                                'zip' => '27571' })
      }
      let(:address) { listing.address }

      it 'has correct data' do
        expect(address.street).to eq('100 Elm Street')
        expect(address.zip).to eq('27571')
      end
    end

  end
end

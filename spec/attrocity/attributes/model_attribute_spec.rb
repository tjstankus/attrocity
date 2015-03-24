module Attrocity
  RSpec.describe ModelAttribute do

      let(:listing) {
        Examples::Listing.new({ 'listingid' => '1234',
                                'addressline1' => '100 Elm Street',
                                'zip' => '27571' })
      }
      let(:address) { listing.address }

      it 'instantiates composed model object' do
        expect(address.street).to eq('100 Elm Street')
        expect(address.zip).to eq('27571')
      end

      it 'provides model object' do
        model_attr = ModelAttribute.new(:address, Examples::Address)
        address = model_attr.model(
          { 'addressline1' => '100 Elm Street',
            'zip' => '27571' })
        expect(address.street).to eq('100 Elm Street')
        expect(address.zip).to eq('27571')
      end

  end
end

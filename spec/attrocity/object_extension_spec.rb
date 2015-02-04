module Attrocity
  RSpec.describe 'Object extension' do
    before(:context) do
      module Examples
        module Spotlight
          include Attrocity.module
          attribute :spotlight, coercer: :boolean
        end

        module MobileSpotlight
          include Attrocity.module
          attribute :spotlight, coercer: :boolean, from: :mobilespotlight
        end
      end
    end

    describe 'without attribute mapping' do
      let(:listing) {
        Examples::Listing.new({ listingid: '1234', spotlight: 0 })
      }

      it 'adds module attributes to object' do
        expect {
          listing.extend(Examples::Spotlight)
        }.to change { listing.respond_to?(:spotlight) }.from(false).to(true)
      end

      it 'returns correct attribute value' do
        listing.extend(Examples::Spotlight)
        expect(listing.spotlight).to be false
      end
    end

    describe 'with attribute mapping' do
      let(:listing) {
        Examples::Listing.new({ listingid: '1234', mobilespotlight: 1 })
      }

      it 'adds module attributes to object' do
        expect {
          listing.extend(Examples::MobileSpotlight)
        }.to change { listing.respond_to?(:spotlight) }.from(false).to(true)
      end

      it 'returns correct attribute value' do
        listing.extend(Examples::MobileSpotlight)
        expect(listing.spotlight).to be true
      end
    end

  end
end

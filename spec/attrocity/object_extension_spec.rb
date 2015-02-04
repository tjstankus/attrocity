module Attrocity
  RSpec.describe 'Object extension' do
    before do
      module Examples
        module Spotlight
          include Attrocity::ModExtensions
          attribute :spotlight, coercer: :boolean
        end
      end
    end

    it 'adds module attributes to object' do
      listing = Examples::Listing.new({ listingid: '1234' })
      expect {
        listing.extend(Examples::Spotlight)
      }.to change { listing.respond_to?(:spotlight) }.from(false).to(true)
    end

    it 'adds module attributes to including class'
  end
end

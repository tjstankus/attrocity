require 'attrocity'

RSpec.describe "Mapping" do
  before do
    # TODO: Move this class declaration to support/examples.rb
    module Examples
      class Listing
        include Attrocity
        attribute :id, coercer: :string, from: :listingid
      end
    end
  end

  let(:data) { { 'listingid' => '1234' } }
  let(:listing) { Examples::Listing.new(data) }

  it 'maps attribute data to attribute name' do
    expect(listing.id).to eq('1234')
  end

  it 'does not respond to from/mapped name' do
    expect { listing.listingid }.to raise_error(NoMethodError)
  end
end

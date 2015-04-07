require 'attrocity/attributes/attribute_template'

module Attrocity
  RSpec.describe AttributeTemplate do
    describe '#mapper_key_for' do
      it "returns mapper key when attribute name matches" do
        attribute = AttributeTemplate.new(
          :street, Coercers::String.new, KeyMapper.new(:addressline1))
        expect(attribute.mapper_key_for(:street)).to eq(:addressline1)
      end

      it "returns mapper key when mapper matches" do
        attribute = AttributeTemplate.new(
          :zip, Coercers::String.new, KeyMapper.new(:zipcode))
        expect(attribute.mapper_key_for(:zipcode)).to eq(:zipcode)
      end

      it 'returns nil when no match' do
        attribute = AttributeTemplate.new(
          :street, Coercers::String.new, KeyMapper.new(:addressline1))
        expect(attribute.mapper_key_for(:nomatch)).to be_nil
      end
    end
  end
end

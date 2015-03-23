require 'attrocity'

module Attrocity
  module Examples

    class Preferences
      include Attrocity.model
      attribute :publish_email, coercer: :boolean, default: false
    end

    class Person
      include Attrocity.model
      attribute :age, coercer: :integer
      model_attribute :preferences, model: Examples::Preferences
    end

    class Address
      include Attrocity.model
      attribute :street, coercer: :string, from: :addressline1
      attribute :zip, coercer: :string
    end

    class Listing
      include Attrocity.model
      attribute :id, coercer: :string, from: :listingid
      model_attribute :address, model: Examples::Address
    end

    class ExampleCoercer
      def coerce(value)
        String(value)
      end
    end

    def self.integer_attribute(name=:an_integer)
      Attrocity::Attribute.new(name,
                               Attrocity::Coercers::Integer.new,
                               default_mapper(name))
    end

    def self.string_attribute(name=:a_string)
      Attrocity::Attribute.new(name,
                               Attrocity::Coercers::String.new,
                               default_mapper(name))
    end

    def self.default_mapper(key)
      Attrocity.default_mapper(key)
    end

  end
end


require 'attrocity'

module Attrocity
  module Examples

    class Person
      include Attrocity.model
      attribute :age, coercer: :integer
    end

    class Listing
      include Attrocity.model
      attribute :id, coercer: :string, from: :listingid
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
      Attrocity::Attribute.default_mapper(key)
    end

  end
end


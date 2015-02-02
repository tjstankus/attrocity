require 'attrocity'

module Attrocity
  module Examples

    class Person
      include Attrocity
      attribute :age, coercer: :integer
    end

    class ExampleCoercer
      def coerce(value)
        String(value)
      end
    end

    def self.integer_attribute(name=:an_integer)
      Attrocity::Attribute.new(:an_integer, Attrocity::Coercers::Integer.new)
    end

    def self.string_attribute(name=:a_string)
      Attrocity::Attribute.new(:a_string, Attrocity::Coercers::String.new)
    end

  end
end


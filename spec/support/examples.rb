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

    def self.integer_attribute
      Attrocity::Attribute.new(:an_integer, Attrocity::Coercers::Integer.new)
    end

    def self.string_attribute
      Attrocity::Attribute.new(:a_string, Attrocity::Coercers::Integer.new)
    end
  end
end


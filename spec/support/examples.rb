require 'attrocity'

module Attrocity
  module Examples
    class Person
      include Attrocity
      attribute :age, coercer: :integer
    end

    module_function

    def integer_attribute
      Attrocity::Attribute.new(:an_integer, Attrocity::Coercers::Integer.new)
    end

    def string_attribute
      Attrocity::Attribute.new(:a_string, Attrocity::Coercers::Integer.new)
    end
  end
end

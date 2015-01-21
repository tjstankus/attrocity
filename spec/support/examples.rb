require 'attrocity'

module Attrocity
  module Examples
    class Person
      include Attrocity
      attribute :age, :integer
    end

    module_function

    def integer_attribute
      Attrocity::Attribute.new(:an_integer)
    end

    def string_attribute
      Attrocity::Attribute.new(:a_string)
    end
  end
end

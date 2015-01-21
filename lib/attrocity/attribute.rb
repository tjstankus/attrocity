module Attrocity
  class Attribute
    attr_reader :name

    def initialize(name, coercer=Coercers::Integer.new)
      @name = name
      @coercer = coercer
    end

    def deep_clone
      self.class.new(name)
    end
  end
end


module Attrocity
  class Attribute
    attr_reader :name, :coercer

    def initialize(name, coercer=Coercers::Integer.new, options={})
      @name = name
      @coercer = coercer
    end

    def deep_clone
      self.class.new(name)
    end

    def value=(value)
      @value = coercer.coerce(value)
    end

    def value
      @value
    end
  end
end


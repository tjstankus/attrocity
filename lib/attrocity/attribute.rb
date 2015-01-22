module Attrocity
  class Attribute
    attr_reader :name, :coercer, :value

    def initialize(name, coercer, options={})
      @name = name
      @coercer = coercer
    end

    def deep_clone
      self.class.new(name, coercer)
    end

    def value=(value)
      @value = coercer.coerce(value)
    end
  end
end


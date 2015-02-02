module Attrocity
  class Attribute
    attr_reader :name, :coercer, :options, :value, :mapper

    def initialize(name, coercer, options={})
      @name = name
      @coercer = coercer
      @options = options
      @mapper = options.fetch(:from, nil)
    end

    def mapped_name
      mapper || name
    end

    def deep_clone
      self.class.new(name, coercer, options)
    end

    def value=(value)
      @value = coercer.coerce(value)
    end
  end
end


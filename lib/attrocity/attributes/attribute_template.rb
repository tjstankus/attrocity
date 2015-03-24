module Attrocity
  class AttributeTemplate

    attr_reader :name, :coercer, :mapper

    def initialize(name, coercer, mapping)
      @name = name
      @coercer = coercer
      @mapper = mapping
    end

    def to_value_attribute(data)
      val = ValueExtractor.new(data, mapper: mapper, coercer: coercer).value
      Attribute.new(name, val)
    end

  end
end


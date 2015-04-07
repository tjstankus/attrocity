module Attrocity
  class AttributeTemplate

    attr_reader :name, :coercer, :mapper

    def initialize(name, coercer, mapping)
      @name = name
      @coercer = coercer
      @mapper = mapping
    end

    def to_attribute(data)
      val = ValueExtractor.new(data, mapper: mapper, coercer: coercer).value
      Attribute.new(name, val)
    end

    def mapper_key_for(key)
      key = key.to_s
      if name.to_s == key || mapper.key.to_s == key
        mapper.key
      else
        nil
      end
    end

  end
end


module Attrocity
  class Attribute

    attr_reader :name, :coercer, :mapper, :default

    def initialize(name, coercer, mapping, default=nil)
      @name = name
      @coercer = coercer
      @default = default
      @mapper = init_mapper(mapping)
    end

    def self.default_mapper(key, default_value)
      KeyMapper.new(key, default_value)
    end

    def to_value_attribute(data)
      val = ValueExtractor.new(data, mapper: mapper, coercer: coercer).value
      ValueAttribute.new(name, val)
    end

    private

    def init_mapper(mapping)
      if mapping.respond_to?(:call)
        mapping
      else
        self.class.default_mapper(mapping, default)
      end
    end
  end
end


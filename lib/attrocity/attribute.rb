require_relative 'key_mapper'

module Attrocity
  class Attribute
    attr_reader :name, :coercer, :mapper, :options, :value

    def initialize(name, coercer, mapper, options={})
      @name = name
      @coercer = coercer
      @mapper = init_mapper(mapper)
      @options = options
    end

    def self.default_mapper(key)
      KeyMapper.new(key)
    end

    def mapper_value(obj, attributes_data)
      mapper.call(obj, attributes_data)
    end

    # TODO: Should we keep this in sync w/ initialize? Perhaps alias?
    def deep_clone
      self.class.new(name, coercer, mapper, options)
    end

    def value=(value)
      @value = coercer.coerce(value)
    end

    private

    def init_mapper(mapper_or_symbol)
      if mapper_or_symbol.respond_to?(:call)
        mapper_or_symbol
      else
        KeyMapper.new(mapper_or_symbol)
      end
    end
  end
end


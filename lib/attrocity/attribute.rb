require_relative 'key_mapper'

module Attrocity
  class Attribute

    attr_reader :name, :coercer, :mapper, :options, :value

    def initialize(name, coercer, mapping, options={})
      @name = name
      @coercer = coercer
      @mapper = init_mapper(mapping)
      @options = options
      @default = options.fetch(:default, nil)
      self.value = @default unless @default.nil?
    end

    def self.default_mapper(key)
      KeyMapper.new(key)
    end

    def mapper_value(obj, attributes_data)
      mapper.call(obj, attributes_data)
    end

    # TODO: Somehow keep this in sync w/ initialize? Perhaps alias?
    def deep_clone
      # puts "deep_clone options -- " + options.inspect
      self.class.new(name, coercer, mapper, options)
    end

    def value=(value)
      # puts "value -- " + value.inspect
      @value = coercer.coerce(value)
      # puts "@value -- " + @value.inspect
    end

    private

    def init_mapper(mapping)
      if mapping.respond_to?(:call)
        mapping
      else
        KeyMapper.new(mapping)
      end
    end
  end
end


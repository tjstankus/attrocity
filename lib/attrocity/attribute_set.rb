require_relative 'attributes_hash'

module Attrocity

  class AttributeSet
    attr_reader :attributes

    def initialize(attributes=[])
      @attributes = attributes
    end

    def deep_clone
      self.class.new(attributes.collect(&:deep_clone))
    end

    def add(attribute)
      attributes << attribute
    end
    alias_method :<<, :add

    def [](attr_name)
      attribute_for_name(attr_name).value
    end

    def to_h
      Hash.new.tap do |h|
        attributes.each { |attr| h[attr.name] = attr.value }
      end
    end

    def set_values(obj, data)
      attributes_data = AttributesHash.new(data)
      attributes.each do |attr|
        if attr.value.nil?
          attr.value = attr.mapper_value(obj, attributes_data)
        end
      end
    end

    def set_value_for(attr_name, value)
      attribute_for_name(attr_name).value = value
    end

    def attribute_for_name(name)
      attributes.detect { |att| att.name == name }
    end

    # TODO: Use a builder for model attributes too?
    def define_methods(obj)
      AttributeMethodsBuilder.new(obj, attributes).define_methods
    end
  end
end

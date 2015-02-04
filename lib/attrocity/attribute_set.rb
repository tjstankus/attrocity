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
      # TODO: return a hash of attribute names and values
    end

    def set_values(obj, data)
      attributes_data = AttributesHash.new(data)
      attributes.each do |attr|
        attr.value = attr.mapper_value(obj, attributes_data)
      end
    end

    def set_value_for(attr_name, value)
      attribute_for_name(attr_name).value = value
    end

    def attribute_for_name(name)
      attributes.detect { |att| att.name == name }
    end

    def define_attribute_methods_on(obj)
      AttributeMethodsBuilder.new(obj, attributes).define_methods
    end
  end
end

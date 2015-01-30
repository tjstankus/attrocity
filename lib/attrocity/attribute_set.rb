require 'hashie'

module Attrocity
  class AttributesHash < Hash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IndifferentAccess
  end

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

    def set_values(data)
      attributes_hash = AttributesHash.new(data)
      attributes.each do |attr|
        attr.value = attributes_hash.fetch(attr.name)
      end
    end

    def set_value_for(attr_name, value)
      attribute_for_name(attr_name).value = value
    end

    # TODO: Consider moving create_ methods to an object that takes an
    # attribute_set and an object on instantiation.
    def create_attribute_methods_on(obj)
      create_reader_on(obj)
      # TODO: :age=
      # obj.age = 39
      # obj.age? => true
    end

    def create_reader_on(obj)
      attributes.each do |attr|
        obj.define_singleton_method(attr.name) { attr.value }
      end
    end

    private

    def attribute_for_name(name)
      attributes.detect { |att| att.name == name }
    end

  end
end

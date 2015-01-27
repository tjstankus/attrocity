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

    def to_h
      # TODO: return a hash of attribute names and values
    end

    def set_values(data)
      attributes_hash = AttributesHash.new(data)
      attributes.each do |attr|
        attr.value = attributes_hash.fetch(attr.name)
      end
    end
  end
end

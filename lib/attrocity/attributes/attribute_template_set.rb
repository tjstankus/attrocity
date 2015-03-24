require_relative 'attributes_hash'

module Attrocity
  class AttributeTemplateSet
    attr_reader :attributes

    def initialize(attributes=[])
      @attributes = attributes
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

    def attribute_for_name(name)
      attributes.detect { |att| att.name == name }
    end

    def to_attribute_set(data)
      AttributeSet.new.tap do |set|
        self.attributes.each do |attr_template|
          set << attr_template.to_attribute(data)
        end
      end
    end

  end
end

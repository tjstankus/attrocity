module Attrocity
  class AttributeSet
    attr_reader :attributes

    def initialize(attributes=[])
      @attributes = attributes
    end

    def deep_clone
      self.class.new(attributes.collect(&:deep_clone))
    end

    def <<(attribute)
      attributes << attribute
    end

    def to_h
      # TODO: return a hash of attribute names and values
    end

    def set_values(data)
      attributes.each do |attr|
        attr.value = data.fetch(attr.name)
      end
    end
  end
end

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
  end
end

module Attrocity
  class AttributeSet
    attr_reader :attributes

    def initialize
      @attributes = []
    end

    def <<(attribute)
      attributes << attribute
    end
  end
end

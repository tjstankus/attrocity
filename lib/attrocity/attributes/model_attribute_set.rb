module Attrocity
  class ModelAttributeSet
    attr_reader :model_attributes

    def initialize
      @model_attributes = []
    end

    def add(model_attribute)
      model_attributes << model_attribute
    end
    alias_method :<<, :add
  end
end

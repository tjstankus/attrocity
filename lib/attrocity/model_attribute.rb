module Attrocity
  class ModelAttribute
    attr_reader :name, :model_class

    def initialize(name, model_class)
      @name = name
      @model_class = model_class
    end

    def model(data)
      model_class.new(AttributesHash.new(data)).model
    end
  end
end

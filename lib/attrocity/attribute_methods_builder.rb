module Attrocity
  class AttributeMethodsBuilder

    attr_reader :object, :attributes

    def initialize(object, attributes)
      @object = object
      @attributes = attributes
    end

    def define_methods
      attributes.each do |attr|
        define_reader(attr)
        define_writer(attr)
        define_predicate(attr)
      end
    end

    def define_reader(attribute)
      object.define_singleton_method(attribute.name) { attribute.value }
    end

    def define_writer(attribute)
      object.define_singleton_method("#{attribute.name}=") do |value|
        attribute.value = value
      end
    end

    def define_predicate(attribute)
      object.define_singleton_method("#{attribute.name}?") do
        !!(attribute.value)
      end
    end
  end
end

module Attrocity
  class ValueAttributeMethodsBuilder

    attr_reader :object, :attributes

    def initialize(object, attributes)
      @object, @attributes = object, attributes
    end

    def self.for_attribute(obj, attribute)
      self.new(obj, Array(attribute))
    end

    def self.for_attribute_set(obj, attribute_set)
      self.new(obj, attribute_set.attributes)
    end

    def build
      attributes.each do |attr|
        define_methods(attr)
      end
    end

    def define_methods(attribute)
      define_reader(attribute)
      define_writer(attribute)
      define_predicate(attribute)
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
        # TODO: Would true & attribute.value work better here?
        !!(attribute.value)
      end
    end
  end
end

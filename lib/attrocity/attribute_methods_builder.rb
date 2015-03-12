module Attrocity
  class AttributeMethodsBuilder

    attr_reader :object

    def initialize(object)
      @object = object
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

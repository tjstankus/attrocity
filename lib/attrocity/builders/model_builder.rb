module Attrocity
  class ModelBuilder < Module
    def included(klass)
      klass.extend(Attrocity::ModuleMethods)
      klass.class_eval do
        attr_reader :raw_data, :attribute_set
      end
      klass.send(:include, Initializer)
      klass.send(:include, InstanceMethods)
    end

    module Initializer
      def initialize(data={})
        @raw_data = AttributesHash.new(data)
        @attribute_set = self.class.attribute_set.to_instance_attributes(@raw_data)
        define_methods
        setup_model_attributes
      end
    end

    module InstanceMethods
      def model
        Model.new(@attribute_set.to_h.merge(model_attributes_hash))
      end

      # TODO: InstanceAttribute => ValueAttribute
      # AttributeMethodsBuilder do define methods for attribute set or individual attributes

      private

      def define_methods
        methods_builder = AttributeMethodsBuilder.new(self)
        attribute_set.attributes.each do |attr|
          methods_builder.define_methods(attr)
        end
      end

      def setup_model_attributes
        model_attributes.each do |model_attr|
          name = model_attr.name
          define_singleton_method(name) {
            instance_eval("@#{name} ||= model_attr.model(raw_data)")
          }
        end
      end

      def model_attributes
        @model_attributes ||= self.class.model_attribute_set.model_attributes
      end

      def model_attributes_hash
        Hash.new.tap do |h|
          model_attributes.each do |model_attr|
            name = model_attr.name
            h[name] = self.send(name)
          end
        end
      end
    end
  end
end

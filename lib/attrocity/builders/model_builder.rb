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
        @raw_data = data
        @instance_attributes = Attrocity::InstanceAttributeSet.new
        @attribute_set = self.class.attribute_set.deep_clone
        init_instance_attributes
        AttributeMethodsBuilder.new(self, @instance_attributes.attributes).define_methods
        # setup_attributes
        setup_model_attributes
      end
    end

    module InstanceMethods
      def model
        Model.new(@instance_attributes.to_h.merge(model_attributes_hash))
      end

      def setup_attributes
        attribute_set.set_values(self, raw_data)
        attribute_set.define_methods(self)
      end

      def setup_model_attributes
        model_attributes.each do |model_attr|
          name = model_attr.name
          define_singleton_method(name) {
            instance_eval("@#{name} ||= model_attr.model(raw_data)")
          }
        end
      end

      private

      def init_instance_attributes
        class_attribute_set = attribute_set
        class_attribute_set.attributes.each do |class_attr|
          default = class_attr.default
          value = ValueExtractor.new(
            AttributesHash.new(raw_data),
            mapper: class_attr.mapper,
            coercer: class_attr.coercer).value
          @instance_attributes << InstanceAttribute.new(class_attr.name, value)
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

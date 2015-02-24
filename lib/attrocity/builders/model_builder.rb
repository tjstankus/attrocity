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
        @attribute_set = self.class.attribute_set.deep_clone
        Attrocity.perform_attributes_actions(self)
        setup_model_attributes
      end
    end

    module InstanceMethods
      def model
        Model.new(attribute_set.to_h)
      end

      private

      def setup_model_attributes
        self.class.model_attribute_set.model_attributes.each do |model_attr|
          name = model_attr.name
          define_singleton_method(name) {
            instance_eval("@#{name} ||= " +
              "model_attr.model_class.new(raw_data).model")
          }
        end
      end
    end
  end
end

module Attrocity
  class ModelBuilder < Module
    def included(klass)
      klass.extend(Attrocity::ModuleMethods)
      klass.class_eval do
        attr_reader :raw_data, :attribute_set
      end
      klass.send(:include, Initializer)
    end

    module Initializer
      def initialize(data={})
        @raw_data = data
        @attribute_set = self.class.attribute_set.deep_clone
        Attrocity.perform_attributes_actions(self)
      end
    end
  end
end

module Attrocity
  class ModelBuilder < Module
    def included(klass)
      klass.extend(Attrocity::ModuleMethods)
      klass.class_eval do
        attr_reader :raw_data, :attribute_set
      end
      klass.send(:include, Initializer)
    end
  end
end

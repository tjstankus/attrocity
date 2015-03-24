module Attrocity
  class ObjectExtensionBuilder < Module

    def included(mod)
      mod.extend(Attrocity::ModuleMethods)
      mod.extend(ModuleHooks)
    end

    module ModuleHooks
      def extend_object(obj)
        value_attr_set = self.attribute_set.to_value_attribute_set(obj.raw_data)
        obj.attribute_set << value_attr_set.attributes
        AttributeMethodsBuilder.for_attribute_set(obj, value_attr_set).build
      end
    end

  end
end

module Attrocity
  class ModuleBuilder < Module

    def included(mod)
      mod.extend(Attrocity::ClassMethods)
      mod.extend(Hooks)
    end

    module Hooks
      def extend_object(obj)
        self.attribute_set.attributes.each do |mod_attr|
          obj.attribute_set << mod_attr
        end
        obj.attribute_set.set_values(obj, obj.raw_data)
        obj.attribute_set.define_methods(obj)
      end
    end

  end
end

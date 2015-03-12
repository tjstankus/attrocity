module Attrocity
  class ObjectExtensionBuilder < Module

    def included(mod)
      mod.extend(Attrocity::ModuleMethods)
      mod.extend(ModuleHooks)
    end

    module ModuleHooks
      def extend_object(obj)
        methods_builder = AttributeMethodsBuilder.new(obj, [])
        self.attribute_set.attributes.each do |mod_attr|
          default = mod_attr.default
          value = ValueExtractor.new(
            AttributesHash.new(obj.raw_data),
            mapper: mod_attr.mapper,
            coercer: mod_attr.coercer).value
          attr = InstanceAttribute.new(mod_attr.name, value)
          obj.attribute_set << attr
          methods_builder.define_methods_for(attr)
        end
      end
    end

  end
end

module Attrocity
  class ModuleBuilder < Module

    def included(mod)
      mod.extend(Attrocity::ModuleMethods)
      mod.extend(ModuleHooks)
    end

    module ModuleHooks
      def extend_object(obj)
        self.attribute_set.attributes.each do |mod_attr|
          obj.attribute_set << mod_attr
        end
        # TODO: https://www.pivotaltracker.com/story/show/89015658
        obj.setup_attributes
      end
    end

  end
end

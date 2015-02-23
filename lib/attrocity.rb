require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_methods_builder'
require 'attrocity/attribute_set'
require 'attrocity/attributes_hash'
require 'attrocity/model'
require 'attrocity/builders/model_builder'
require 'attrocity/builders/module_builder'
require 'attrocity/coercer_registry'
require 'attrocity/coercers/boolean'
require 'attrocity/coercers/integer'
require 'attrocity/coercers/string'

module Attrocity

  def self.model
    ModelBuilder.new
  end

  def self.module
    ModuleBuilder.new
  end

  # TODO: This should probably be an instance method on obj
  def self.perform_attributes_actions(obj)
    obj.attribute_set.set_values(obj, obj.raw_data)
    obj.attribute_set.define_methods(obj)
  end

  module ModuleMethods
    def attribute(name,
                  coercer:,
                  from: Attribute.default_mapper(name),
                  default: nil)
      coercer = CoercerRegistry.instance_for(coercer)
      options = {}
      if default
        options[:default] = default
      end
      attribute_set << Attribute.new(name, coercer, from, options)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end

Attrocity::CoercerRegistry.register do
  add :boolean, Attrocity::Coercers::Boolean
  add :integer, Attrocity::Coercers::Integer
  add :string, Attrocity::Coercers::String
end

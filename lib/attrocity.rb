require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_methods_builder'
require 'attrocity/attribute_set'
require 'attrocity/attributes_hash'
require 'attrocity/model'
require 'attrocity/model_attribute'
require 'attrocity/model_attribute_set'
require 'attrocity/builders/object_extension_builder'
require 'attrocity/builders/model_builder'
require 'attrocity/coercer_registry'
require 'attrocity/coercers/boolean'
require 'attrocity/coercers/integer'
require 'attrocity/coercers/string'

module Attrocity

  def self.model
    ModelBuilder.new
  end

  def self.object_extension
    ObjectExtensionBuilder.new
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

    def model_attribute(name, model:)
      ModelAttribute.new(name, model).tap do |model_attr|
        model_attribute_set << model_attr
      end
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end

    def model_attribute_set
      @model_attribute_set ||= ModelAttributeSet.new
    end
  end

end

Attrocity::CoercerRegistry.register do
  add :boolean, Attrocity::Coercers::Boolean
  add :integer, Attrocity::Coercers::Integer
  add :string, Attrocity::Coercers::String
end

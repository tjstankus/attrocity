require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_methods_builder'
require 'attrocity/attribute_set'
require 'attrocity/attributes_hash'
require 'attrocity/module_builder'
require 'attrocity/coercer_registry'
require 'attrocity/coercers/boolean'
require 'attrocity/coercers/integer'
require 'attrocity/coercers/string'

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  attr_reader :raw_data, :attribute_set

  module Initializer
    def initialize(data={})
      @raw_data = data
      @attribute_set = self.class.attribute_set.deep_clone

      # TODO: Do this work elsewhere
      @attribute_set.set_values(self, @raw_data)
      @attribute_set.define_methods(self)
    end
  end

  module ClassMethods
    def attribute(name, coercer:, from: Attribute.default_mapper(name))
      coercer = CoercerRegistry.instance_for(coercer)
      attribute_set << Attribute.new(name, coercer, from)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

  def self.module
    ModuleBuilder.new
  end

end

Attrocity::CoercerRegistry.register do
  add :boolean, Attrocity::Coercers::Boolean
  add :integer, Attrocity::Coercers::Integer
  add :string, Attrocity::Coercers::String
end

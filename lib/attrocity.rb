require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_set'
require 'attrocity/coercer_registry'
require 'attrocity/coercers/boolean'
require 'attrocity/coercers/integer'
require 'attrocity/coercers/string'

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  def attributes
    attribute_set.to_h
  end

  attr_reader :raw_data, :attribute_set

  module Initializer
    def initialize(data={})
      @raw_data = data
      @attribute_set = self.class.attribute_set.deep_clone

      # TODO: Do this work elsewhere
      @attribute_set.set_values(@raw_data)
      @attribute_set.create_attribute_methods_on(self)
    end
  end

  module ClassMethods
    # TODO: options for :default, :from
    def attribute(name, coercer:, from: nil)
      # TODO: Make a coercer object from the coercer registry, for now hardcode
      coercer = Coercers::Integer.new
      attribute_set << Attribute.new(name, coercer)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end

Attrocity::CoercerRegistry.register do
  add :integer, Attrocity::Coercers::Integer
  add :string, Attrocity::Coercers::String
end

require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_set'

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  module Initializer
    def initialize(data={})
      # Dup/clone class AttributeSet to instance scope
    end
  end

  module ClassMethods
    def attribute(name, coercer, options={})
      # Create a new Attribute and add it to the class AttributeSet
      attribute_set << Attribute.new(name)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end

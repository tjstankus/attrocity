require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_set'

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  attr_reader :attribute_set

  module Initializer
    def initialize(data={})
      @attribute_set = self.class.attribute_set.deep_clone
    end
  end

  module ClassMethods
    def attribute(name, coercer, options={})
      attribute_set << Attribute.new(name)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end

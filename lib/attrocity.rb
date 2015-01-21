require "attrocity/version"

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  module Initializer
    def initialize(data={})
    end
  end

  module ClassMethods
    def attribute(name, coercer, options={})
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end

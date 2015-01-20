require "attrocity/version"

module Attrocity

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def attribute(name, coercer, options={})
    end
  end

end

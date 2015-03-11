module Attrocity
  class InstanceAttributeSet

    attr_reader :attributes

    def initialize
      @attributes = Array.new
    end

    def add(attribute)
      attributes << attribute
    end
    alias_method :<<, :add

    def to_h
      Hash.new.tap do |h|
        attributes.each do |attr|
          h[attr.name] = attr.value
        end
      end
    end

  end
end

module Attrocity
  class AttributeSet

    attr_reader :attributes

    def initialize
      @attributes = Array.new
    end

    def add(attrs)
      Array(attrs).each { |attr| attributes << attr }
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

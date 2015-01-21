module Attrocity
  class Attribute
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def deep_clone
      self.class.new(name)
    end
  end
end


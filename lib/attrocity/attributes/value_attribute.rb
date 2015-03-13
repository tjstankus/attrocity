module Attrocity
  class ValueAttribute
    attr_reader :name
    attr_accessor :value

    def initialize(name, value)
      @name, @value = name, value
    end
  end
end

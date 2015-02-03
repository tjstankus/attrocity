module Attrocity
  class Mapper
    def to_mapper
      self
    end

    def call
      raise "implement in subclass"
    end
  end
end

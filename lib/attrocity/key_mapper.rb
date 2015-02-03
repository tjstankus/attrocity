module Attrocity
  class KeyMapper

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def call(_, attributes_data)
      attributes_data[key]
    end
  end
end

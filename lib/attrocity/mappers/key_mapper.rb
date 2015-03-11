module Attrocity
  class KeyMapper
    attr_reader :key, :default_value

    def initialize(key, default_value=nil)
      @key = key
      @default_value = default_value
    end

    def call(_, attributes_data)
      attributes_data.fetch(key, default_value)
    end
  end
end

module Attrocity
  class ValueExtractor
    attr_reader :mapper, :coercer, :data, :default_value

    def initialize(data, mapper, coercer, default_value=nil)
      @data, @mapper, @coercer, @default_value = data, mapper, coercer, default_value
    end

    def value
      mapped_value = map
      if mapped_value == default_value
        mapped_value
      else
        coerce(mapped_value)
      end
    end

    private

    def map
      mapper.call(nil, data) rescue default_value
    end

    def coerce(value)
      coercer.coerce(value)
    end
  end
end

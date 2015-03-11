module Attrocity
  class ValueExtractor
    attr_reader :data, :mapper, :coercer

    def initialize(data, mapper:, coercer:)
      @data, @mapper, @coercer = data, mapper, coercer
    end

    def value
      coerce(map)
    end

    private

    def map
      mapper.call(nil, data)
    end

    def coerce(value)
      coercer.coerce(value)
    end
  end
end

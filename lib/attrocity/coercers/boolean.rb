module Attrocity
  module Coercers
    class Boolean

      def coerce(value)
        true & value
      end

    end
  end
end


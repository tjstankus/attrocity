module Attrocity
  module Coercers
    class Boolean
      def coerce(value)
        true_values.include?(value)
      end

      private

      def true_values
        [true, '1', 1]
      end
    end
  end
end


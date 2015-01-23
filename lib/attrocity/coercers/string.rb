module Attrocity
  module Coercers
    class String
      def coerce(value)
        String(value)
      end
    end
  end
end


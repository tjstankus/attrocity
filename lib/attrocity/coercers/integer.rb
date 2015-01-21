module Attrocity
  module Coercers
    class Integer
      def coerce(value)
        Integer(value)
      end
    end
  end
end

module Attrocity
  module Coercers
    class Integer
      def coerce(value)
        value.nil? ? value : Integer(value)
      rescue TypeError, ArgumentError
        raise Attrocity::CoercionError
      end
    end
  end
end

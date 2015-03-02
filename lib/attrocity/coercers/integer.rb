module Attrocity
  module Coercers
    class Integer
      def coerce(value)
        Integer(value) rescue nil
      end
    end
  end
end

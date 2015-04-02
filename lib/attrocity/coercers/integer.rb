module Attrocity
  module Coercers
    class Integer
      def coerce(value)
        if value.nil? || value.to_s.empty?
          nil
        else
          Integer(value)
        end
      end
    end
  end
end

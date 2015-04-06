module Attrocity
  module Coercers
    class String
      def coerce(value)
        if value.nil?
          nil
        else
          String(value)
        end
      end
    end
  end
end


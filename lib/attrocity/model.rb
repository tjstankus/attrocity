module Attrocity
  class Model
    def initialize(attributes)
      attributes.each do |k,v|
        self.define_singleton_method(k) { v }
        self.define_singleton_method("#{k}?") { !!v }
      end
    end
  end
end

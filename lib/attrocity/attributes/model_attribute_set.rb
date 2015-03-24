module Attrocity
  class ModelAttributeSet < AttributeSet
    def to_h
      Hash.new.tap do |h|
        attributes.each do |model_attr|
          name = model_attr.name
          h[name] = self.send(name)
        end
      end
    end
  end
end

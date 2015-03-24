require_relative 'attribute_set'
require_relative 'attributes_hash'

module Attrocity
  class AttributeTemplateSet < AttributeSet

    def to_attribute_set(data)
      AttributeSet.new.tap do |set|
        self.attributes.each do |attr_template|
          set << attr_template.to_attribute(data)
        end
      end
    end

  end
end

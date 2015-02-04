require 'hashie'

module Attrocity
  class AttributesHash < Hash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IndifferentAccess
  end
end


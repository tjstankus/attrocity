require 'attrocity'

module Examples
  class Person
    include Attrocity
    attribute :age, :integer
  end
end

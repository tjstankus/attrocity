module Attrocity
  class CoercerRegistry
    def self.register(&block)
      class_eval(&block) if block_given?
    end

    def self.add(name, coercer_class)
      registry[name] = coercer_class
    end

    def self.to_s
      registry.inspect
    end

    def self.coercer_for(name)
      registry[name]
    end

    def self.instance_for(name)
      coercer_for(name).new
    end

    private

    def self.registry
      @registry ||= {}
    end
  end
end


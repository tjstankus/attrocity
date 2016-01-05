module Attrocity

  UnknownCoercerError = Class.new(StandardError)

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
      registry.fetch(name)
    rescue KeyError
      raise UnknownCoercerError
    end

    def self.instance_for(name, params={})
      if params.empty?
        coercer_for(name).new
      else
        coercer_for(name).new(params)
      end
    end

    private

    def self.registry
      @registry ||= {}
    end
  end
end

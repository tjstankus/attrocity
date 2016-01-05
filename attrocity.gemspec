# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attrocity/version'

Gem::Specification.new do |spec|
  spec.name          = "attrocity"
  spec.version       = Attrocity::VERSION
  spec.authors       = ["TJ Stankus"]
  spec.email         = ["tjstankus@gmail.com"]
  spec.summary       = %q{Declarative attributes in Ruby}
  spec.description   = %q{You should totally be using Virtus instead of this}
  spec.homepage      = "https://github.com/tjstankus/attrocity"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'hashie', '~> 3.4'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency 'rspec', '~> 3.4'
end

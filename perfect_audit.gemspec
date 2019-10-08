# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perfect_audit/version'

Gem::Specification.new do |spec|
  spec.name          = "perfect_audit"
  spec.version       = PerfectAudit::VERSION
  spec.authors       = ["Igor Alexandrov"]
  spec.email         = ["igor.alexandrov@gmail.com"]

  spec.summary       = %q{Perfect Audit API wrapper.}
  spec.description   = %q{Perfect Audit API wrapper. https://www.ocrolus.com/api-doc/}
  spec.homepage      = "https://github.com/igor-alexandrov/perfect_audit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.3'

  # a b c d e f g h i j k l m n o p q r s t u v w x y z
  spec.add_dependency 'dry-auto_inject'
  spec.add_dependency 'dry-container'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'http'
  spec.add_dependency 'http-form_data'


  spec.add_development_dependency 'bundler', "~> 1.11"

  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'faker'

  spec.add_development_dependency 'pry'

  spec.add_development_dependency 'rake', "~> 10.0"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'rspec-collection_matchers'

  spec.add_development_dependency 'simplecov'

  spec.add_development_dependency 'webmock'

  spec.add_development_dependency 'yard'
end

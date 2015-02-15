# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-cronofy/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-cronofy"
  spec.version       = OmniAuth::Cronofy::VERSION
  spec.authors       = ["Adam Bird"]
  spec.email         = ["support@cronofy.com"]

  spec.description   = "OmniAuth strategy for authenticating with Cronofy"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/cronofy/omniauth-cronofy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.2"
  spec.add_dependency "omniauth-oauth2", "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end

# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keypic/version'

Gem::Specification.new do |spec|
  spec.name          = "keypic"
  spec.version       = Keypic::VERSION
  spec.authors       = ["Igor Galeta"]
  spec.email         = ["galeta.igor@gmail.com"]
  spec.description   = %q{Client for Keypic Web Service API}
  spec.summary       = %q{Keypic is a Web Service for avoid the use of CAPTCHAs}
  spec.homepage      = "http://keypic.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httpi"
  spec.add_dependency "multi_json"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

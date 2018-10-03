# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday-request-timer/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday-request-timer"
  spec.version       = FaradayRequestTimer::VERSION
  spec.authors       = ["Brandon Weiss"]
  spec.email         = ["brandon@anti-pattern.com"]
  spec.summary       = %q{Faraday request timing}
  spec.description   = %q{Includes the request time in a Faraday response}
  spec.homepage      = "http://github.com/canaryup/faraday-request-timer"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"] + Dir["test/**/*.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 0.9.0"

  spec.add_development_dependency "bundler",  "~> 1.5"
  spec.add_development_dependency "minitest", "~> 5.11.3"
  spec.add_development_dependency "mocha",    "~> 1.1.0"
end

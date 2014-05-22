# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syachicky/version'

Gem::Specification.new do |spec|
  spec.name          = "syachicky"
  spec.version       = Syachicky::VERSION
  spec.authors       = ["matsu-chara"]
  spec.email         = ["matsuy00@gmail.com"]
  spec.summary       = %q{stock price printer}
  spec.description   = %q{a stock price printer for all syachikus}
  spec.homepage      = "https://github.com/matsu-chara/syachicky"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "json"
  spec.add_dependency "activesupport"
  spec.add_dependency "sorry_yahoo_finance"
end

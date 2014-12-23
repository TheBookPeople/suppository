# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'suppository/version'

Gem::Specification.new do |spec|
  spec.name          = "suppository"
  spec.version       = Suppository::VERSION
  spec.authors       = ["William Griffiths"]
  spec.email         = ["william.griffiths@thebookpeople.co.uk"]
  spec.summary       = %q{Super Simple Apt Repository Manager}
  spec.description   = %q{A utility for creating and managing simple apt repositories.}
  spec.homepage      = ""
  spec.license       = "GNU"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

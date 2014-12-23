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

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  
  spec.add_development_dependency 'rspec', '2.14.1' 
  spec.add_development_dependency 'guard-rspec','4.2.9'
  spec.add_development_dependency 'rb-inotify' 
  spec.add_development_dependency 'rb-fsevent' 
  spec.add_development_dependency 'rb-fchange', '0.0.6' 
  spec.add_development_dependency 'terminal-notifier-guard', '1.5.3'
  
end

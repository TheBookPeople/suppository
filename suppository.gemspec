# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'suppository/version'

Gem::Specification.new do |spec|
  spec.name          = "suppository"
  spec.version       = Suppository::VERSION
  spec.version       = "#{s.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  spec.authors       = ["William Griffiths"]
  spec.email         = ["william.griffiths@thebookpeople.co.uk"]
  spec.summary       = %q{Super Simple Apt Repository Manager}
  spec.description   = %q{A utility for creating and managing simple apt repositories.}
  spec.homepage      = "https://github.com/TheBookPeople/suppository"
  spec.license       = "GNU"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "bundler", '~> 1.7'
  spec.add_development_dependency 'rspec', '~> 3.1' 
  spec.add_development_dependency 'guard-rspec','~> 4.5'
  spec.add_development_dependency 'rb-inotify','~> 0.9' 
  spec.add_development_dependency 'rb-fsevent' ,'~> 0.9' 
  spec.add_development_dependency 'rb-fchange', '~> 0.0' 
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6'
  spec.add_development_dependency 'rubocop' , '~> 0.28'
  spec.add_development_dependency 'fakefs', '~> 0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  
end

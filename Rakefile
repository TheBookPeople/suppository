require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'
require 'simplecov'


task :default => [:rubocop,:test]

task :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.verbose = false
  end
  
  Rake::Task["spec"].execute
end


task :rubocop do
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['lib/**/*.rb']
    task.fail_on_error = true
  end
end
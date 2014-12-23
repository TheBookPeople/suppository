require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'ruby-lint/rake_task'
require "bundler/gem_tasks"


task :default => [:rubocop,:lint,:test]

task :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*/_spec.rb'
  end
  Rake::Task["spec"].execute
end


task :rubocop do
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['lib/**/*.rb']
    task.fail_on_error = false
  end
end


task :lint do
  RubyLint::RakeTask.new do |task|
    task.name  = 'lint'
    task.files = FileList.new('lib/**/*.rb')
  end
end

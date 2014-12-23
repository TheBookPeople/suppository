require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default => [:test]

task :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*/_spec.rb'
  end
  Rake::Task["spec"].execute
end


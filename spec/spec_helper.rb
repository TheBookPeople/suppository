require 'logger'
require 'fakefs/spec_helpers'
require 'rspec/mocks/standalone'
require 'stringio'
require 'simplecov'

SimpleCov.start do
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

RSpec.configure do |config| 
  config.before do
    $stdout = StringIO.new
  end
  
  config.after(:all) do
    $stdout = STDOUT
  end
   
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.color = true
  config.mock_with :rspec
  config.order = 'random'
  config.raise_errors_for_deprecations!
end

 
def get_exception 
  e_message = ""
  begin      
    yield
  rescue => e
    e_message = e.message
  end 
  e_message
end

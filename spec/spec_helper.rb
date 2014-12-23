require 'logger'
require 'fakefs/spec_helpers'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

RSpec.configure do |config|  
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true
  config.mock_with :rspec
  config.order = 'random'
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

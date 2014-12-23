require 'logger'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

RSpec.configure do |config|  
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true
  config.mock_with :rspec
  config.order = 'random'
end

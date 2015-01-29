
require 'spec_helper'
require 'suppository/version_command'

describe Suppository::VersionCommand do
  it 'shows version number' do
    command = Suppository::VersionCommand.new([])
    expect { command.run }.to output("Suppository Version #{Suppository::VERSION}\n").to_stdout
  end
end

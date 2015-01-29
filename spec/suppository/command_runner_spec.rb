
require 'spec_helper'
require 'suppository/command_runner'
require 'suppository/exceptions'

describe Suppository::CommandRunner do
  it 'run command' do
    runner = Suppository::CommandRunner.new('echo', '1234')
    expect(runner.run).to eql("1234\n")
  end

  it 'command not found' do
    runner = Suppository::CommandRunner.new('notavalidcommand')
    expect { runner.run }.to raise_error(CommandMissingError)
  end

  it 'command error' do
    runner = Suppository::CommandRunner.new('man', '--invalidoption')
    expect { runner.run }.to raise_error(CommandError)
  end
end

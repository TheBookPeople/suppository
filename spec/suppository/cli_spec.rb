
require 'spec_helper'
require 'suppository/version'
require 'suppository/cli'
require 'suppository/repository'
require 'suppository/create_command'
require 'suppository/add_command'

describe Suppository::CLI do
  
  before(:each) do
    @path = '/tmp/repo123'
    @repository = double(Suppository::Repository)
  end
  
  it "shows current version" do    
    command = double(Suppository::VersionCommand)
    expect(Suppository::VersionCommand).to receive(:new).with([]) {command}
    expect(command).to receive(:run)
    Suppository::CLI.run(['version'])
  end
  
  it "can create new repository" do    
    creator = double(Suppository::CreateCommand)
    expect(Suppository::CreateCommand).to receive(:new).with([@path]) {creator}
    expect(creator).to receive(:run)
    Suppository::CLI.run(['create', @path])
  end
  
  it "can add deb repository" do  
    adder = double(Suppository::AddCommand)
    expect(Suppository::AddCommand).to receive(:new).with([@path, 'trusty', '/tmp/example.deb']) {adder}
    expect(adder).to receive(:run)   
    Suppository::CLI.run(['add', @path , 'trusty', '/tmp/example.deb'])
  end
  
  it "rase usage error for empty args" do
    expect { 
      Suppository::CLI.run([])
    }.to raise_error(UsageError)
  end
  
  it "rase usage error for invalid command" do
    expect { 
      Suppository::CLI.run(['bla'])
    }.to raise_error(UsageError)
  end
end
  
  
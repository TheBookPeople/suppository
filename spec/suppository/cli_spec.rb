require 'rubygems'
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
    expect(Suppository::VersionCommand).to receive(:new).with(no_args) {command}
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
    usage_error = false
    begin
      Suppository::CLI.run([])
    rescue UsageError
      usage_error = true
    end
    
    expect(usage_error).to be_truthy 
  end
  
  it "rase usage error for invalid command" do
    usage_error = false
    begin
      Suppository::CLI.run(['bla'])
    rescue UsageError
      usage_error = true
    end
    
    expect(usage_error).to be_truthy 
  end
  
  
end
  
  
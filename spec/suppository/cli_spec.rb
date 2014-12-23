require 'rubygems'
require 'spec_helper'
require 'suppository/version'
require 'suppository/cli'
require 'suppository/create_repository'

describe Suppository::CLI do
  
  it "shows current version" do    
    expect{Suppository::CLI.run(["version"])}.to output("Suppository Version 0.0.1\n").to_stdout   
  end
  
  it "can create new repository" do    
    creator = double(Suppository::CreateRepository)
    expect(Suppository::CreateRepository).to receive(:new).with("/tmp/repo123") {creator}
    expect(creator).to receive(:run)
    Suppository::CLI.run(["create", "/tmp/repo123"])
  end
  
  
end
  
  
require 'rubygems'
require 'spec_helper'
require 'suppository/repository'

describe Suppository::Repository do

  before(:each) do
    @repository = Suppository::Repository.new("/tmp/repo123")
    @dists = ['natty','lucid', 'precise', 'soucy', 'trusty']
    @archs = ['amd64','i386']
    @suppository ="/tmp/repo123/.suppository"
  end

  it "has a path" do
    expect(@repository.path).to eql "/tmp/repo123"
  end
  
  it "has a dists" do
    expect(@repository.dists).to eql @dists
  end
  
  it "has a archs" do
    expect(@repository.archs).to eql @archs
  end
  
  it "has a suppository" do
    expect(@repository.suppository).to eql @suppository
  end


end


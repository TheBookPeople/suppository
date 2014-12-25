require 'rubygems'
require 'spec_helper'
require 'suppository/create_command'
require 'suppository/repository'

describe Suppository::CreateCommand do

  include FakeFS::SpecHelpers

  before(:each) do
    @creator = Suppository::CreateCommand.new(['/tmp/repo123/'])
  end

  it "can create new repository" do
    expect{@creator.run}.to output("Creating new Repository @ /tmp/repo123/\n").to_stdout 
  end

  it "can create new repository at different location" do
    creator = Suppository::CreateCommand.new(["/tmp/repo321"])
    expect{creator.run}.to output("Creating new Repository @ /tmp/repo321\n").to_stdout 
  end

  it "creates repository root folder" do
    @creator.run
    expect(File.directory?("/tmp/repo123/")).to be_truthy
  end

  it "creates a .supository file" do
    @creator.run
    expect(File.directory?('/tmp/repo123/.suppository')).to be_truthy
  end

  it "aborts if file supository already exists" do
    repository = Suppository::Repository.new('/tmp/repo123/')
    FileUtils.mkdir_p repository.suppository
    expect(get_exception{@creator.run}).to eql "/tmp/repo123/ is already a repository"
  end

  it "creates folder structure" do
    repository = Suppository::Repository.new('/tmp/repo123/')
    @creator.run
    repository.dists.each do |dist|
      repository.archs.each do |arch|
        expect(File.directory?("#{repository.path}/dists/#{dist}/internal/binary-#{arch}")).to be_truthy
      end
    end
  end
end


require 'rubygems'
require 'spec_helper'
require 'suppository/create_repository'
require 'suppository/repository'

describe Suppository::CreateRepository do

  include FakeFS::SpecHelpers

  before(:each) do
    IO.any_instance.stub(:puts)
    @repository = Suppository::Repository.new("/tmp/repo123/")
    @creator = Suppository::CreateRepository.new(@repository)
  end

  it "can create new repository" do
    STDOUT.should_receive(:puts).with("Creating new Repository @ /tmp/repo123/")
    @creator.run
  end

  it "can create new repository at diffrent location" do
    STDOUT.should_receive(:puts).with("Creating new Repository @ /tmp/repo321")
    repository = Suppository::Repository.new("/tmp/repo321")
    creator = Suppository::CreateRepository.new(repository)
    creator.run
  end

  it "creates repository root folder" do
    @creator.run
    File.directory?("/tmp/repo123/").should be_true
  end

  it "creates a .supository file" do
    @creator.run
    File.directory?(@repository.suppository).should be_true
  end

  it "aborts if file supository already exists" do
    FileUtils.mkdir_p @repository.suppository
    get_exception{@creator.run}.should eql "#{@repository.path} is already a repository"
  end

  it "creates folder structure" do
    @creator.run
    @repository.dists.each do |dist|
      @repository.archs.each do |arch|
        File.directory?("#{@repository.path}/dists/#{dist}/internal/binary-#{arch}").should be_true
      end
    end

  end




end


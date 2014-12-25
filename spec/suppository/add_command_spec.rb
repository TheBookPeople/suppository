require 'rubygems'
require 'spec_helper'
require 'suppository/add_command'
require 'suppository/repository'
require 'suppository/create_command'

describe Suppository::AddCommand do

  include FakeFS::SpecHelpers
  
  before(:each) do
    @repository = Suppository::Repository.new("/tmp/supposotory_test_#{Time.now.to_f}")
    Suppository::CreateCommand.new([@repository.path]).run
    @test_deb = File.expand_path(File.dirname(__FILE__)+"../../../fixtures/curl_7.22.0-3ubuntu4.11_amd64.deb")
    FakeFS::FileSystem.clone(@test_deb)
    @dist = 'trusty'
    @component = 'internal'
    @adder = Suppository::AddCommand.new([@repository.path, @dist, @component, @test_deb])
  end
  
  it "adds package to the supposotory" do  
    @adder.run
    file_name = 'e5ca0a9797acda4bfe8404524f0976b3_b37ce9b17405d93c323c0b8bbe167c6f2dccfe02_5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555.deb'
    expect(File.file?("#{@repository.suppository}/#{file_name}")).to be_truthy
  end
  
  it "adds package to dists" do  
    @adder.run
    @repository.dists.each do |dist|
      @repository.archs.each do |arch|
        if dist == @dist
          expect(File.file?("#{@repository.path}/dists/#{dist}/#{@component}/binary-#{arch}/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_truthy
        else
          expect(File.file?("#{@repository.path}/dists/#{dist}/#{@component}/binary-#{arch}/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_falsy
        end
      end
    end
  end
  
  it "cant add package to new dists" do  
    @adder = Suppository::AddCommand.new([@repository.path, 'new_dist', @component, @test_deb])
    
    error = false
    begin
      @adder.run
    rescue InvalidDistribution
      error = true
    end
    
    expect(error).to be_truthy 
  end
  
  it "cant add package to new component" do  
    @adder = Suppository::AddCommand.new([@repository.path, @dist, 'testing', @test_deb])
    
    error = false
    begin
      @adder.run
    rescue InvalidComponent
      error = true
    end
    
    expect(error).to be_truthy 
  end

end


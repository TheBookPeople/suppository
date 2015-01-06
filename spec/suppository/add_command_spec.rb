require 'rubygems'
require 'spec_helper'
require 'suppository/add_command'
require 'suppository/repository'
require 'suppository/create_command'
require 'suppository/exceptions'

describe Suppository::AddCommand do
    
  before(:each) do
    repository_path = "/tmp/suppository_test_#{Time.now.to_f}/"
    @file_name = 'e5ca0a9797acda4bfe8404524f0976b3_b37ce9b17405d93c323c0b8bbe167c6f2dccfe02_5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555.deb'
    @repository = Suppository::Repository.new(repository_path)
    Suppository::CreateCommand.new([@repository.path]).run
    @dist = 'trusty'
    @component = 'internal'
    @adder = Suppository::AddCommand.new([@repository.path, @dist, @component, deb_file])
  end
  
  after(:each) do
    FileUtils.rm_r @repository.path
  end
  
  it "adds package to the supposotory" do  
    @adder.run
     expect(File.file?("#{@repository.suppository}/#{@file_name}")).to be_truthy
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
  
  it "updates Packages file" do  
    supository_file = "#{@repository.suppository}/#{@file_name}"
    @adder.run
     @repository.archs.each do |arch|
       internal_path = "dists/#{@dist}/#{@component}/binary-#{arch}/"
       path = "#{@repository.path}/#{internal_path}"
       packages_path = "#{path}/Packages"
       deb = Suppository::MasterDeb.new(supository_file)
       content = Suppository::Package.new(internal_path, deb).content
       expect(File.read(packages_path)).to match content
     end
  end
  
  it "updates Packages.gz file" do  
    supository_file = "#{@repository.suppository}/#{@file_name}"
    @adder.run
     @repository.archs.each do |arch|
       internal_path = "dists/#{@dist}/#{@component}/binary-#{arch}/"
       path = "#{@repository.path}/#{internal_path}"
       packages_path = "#{path}/Packages.gz"
       deb = Suppository::MasterDeb.new(supository_file)
       content = Suppository::Package.new(internal_path,deb).content
       result =""
       Zlib::GzipReader.open(packages_path) {|gz|
         result << gz.read
       }
       
       expect(result).to match content
     end
  end
  
 
  
  it "cant add package to new dists" do  
    @adder = Suppository::AddCommand.new([@repository.path, 'new_dist', @component, deb_file])
    
    error = false
    begin
      @adder.run
    rescue InvalidDistribution
      error = true
    end
    
    expect(error).to be_truthy 
  end
  
  it "cant add package to new component" do  
    @adder = Suppository::AddCommand.new([@repository.path, @dist, 'testing', deb_file])
    
    error = false
    begin
      @adder.run
    rescue InvalidComponent
      error = true
    end
    
    expect(error).to be_truthy 
  end
  
  it "needs non nil arguments" do  
    error = false
    begin
     @adder = Suppository::AddCommand.new(nil)
    rescue UsageError
      error = true
    end
    
    expect(error).to be_truthy 
  end
  
  it "needs arguments" do  
    error = false
    begin
     @adder = Suppository::AddCommand.new([])
    rescue UsageError
      error = true
    end
    
    expect(error).to be_truthy 
  end

  it "needs four arguments" do  
    error = false
    begin
     @adder = Suppository::AddCommand.new([@repository.path, @dist, 'testing'])
    rescue UsageError
      error = true
    end
    
    expect(error).to be_truthy 
  end

end


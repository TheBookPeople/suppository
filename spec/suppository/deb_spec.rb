require 'rubygems'
require 'spec_helper'
require 'suppository/deb'

describe Suppository::Deb do
  
  before(:each) do
    @deb_file = File.expand_path(File.dirname(__FILE__)+"../../../fixtures/curl_7.22.0-3ubuntu4.11_amd64.deb")
    @deb = Suppository::Deb.new(@deb_file)
  end

  it "gets attribute by method" do
    expect(@deb.package).to eql 'curl'
  end
  
  it "fails with invalid attribute" do
    error = false
    begin
      @deb.boom
    rescue NoMethodError => error
       error = true
    end
    expect(error).to be_truthy
  end
  
  it "filename" do
    expect(@deb.filename).to eql 'curl_7.22.0-3ubuntu4.11_amd64.deb'
  end
    
end


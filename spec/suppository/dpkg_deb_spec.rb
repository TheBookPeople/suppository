
require 'spec_helper'
require 'suppository/dpkg_deb'

describe Suppository::DpkgDeb do
  
  before(:each) do
    @instance = Suppository::DpkgDeb.new deb_file
  end
  
  it "package" do
    expect(@instance.attibutes['Package']).to eql 'curl'
  end
  
  it "version" do
    expect(@instance.attibutes['Version']).to eql '7.22.0-3ubuntu4.11'
  end
  
  it "architecture" do
    expect(@instance.attibutes['Architecture']).to eql 'amd64'
  end
  
  it "maintainer" do
    expect(@instance.attibutes['Maintainer']).to eql 'Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>'
  end
  
  it "installed size" do
    expect(@instance.attibutes['Installed-Size']).to eql '345'
  end
  
  it "depends" do
    expect(@instance.attibutes['Depends']).to eql 'libc6 (>= 2.14), libcurl3 (>= 7.16.2-1), zlib1g (>= 1:1.1.4)'
  end
  
  it "replaces" do
    expect(@instance.attibutes['Replaces']).to eql 'curl-ssl'
  end
  
  it "provides" do
    expect(@instance.attibutes['Provides']).to eql 'curl-ssl'
  end
  
  it "section" do
    expect(@instance.attibutes['Section']).to eql 'web'
  end

  it "priority" do
    expect(@instance.attibutes['Priority']).to eql 'optional'
  end
  
  it "homepage" do
    expect(@instance.attibutes['Homepage']).to eql 'http://curl.haxx.se'
  end
  
  it "description" do
    expect(@instance.attibutes['Description']).to eql "Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported\n protocols. The command is designed to work without user interaction\n or any kind of interactivity.\n .\n curl offers a busload of useful tricks like proxy support, user\n authentication, FTP upload, HTTP post, file transfer resume and more.\n"
  end
  
  it "original_maintainer" do
    expect(@instance.attibutes['Original-Maintainer']).to eql 'Ramakrishnan Muthukrishnan <rkrishnan@debian.org>'
  end
  
 
end


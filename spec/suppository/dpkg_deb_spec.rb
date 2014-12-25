require 'rubygems'
require 'spec_helper'
require 'suppository/dpkg_deb'

describe Suppository::DpkgDeb do
  
  class String
    def undent
      gsub(/^.{#{slice(/^ +/).length}}/, '')
    end
  end
  
  before(:each) do
    text =<<-EOS.undent
    Package: curl
    Version: 7.22.0-3ubuntu4.11
    Architecture: amd64
    Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    Installed-Size: 345
    Depends: libc6 (>= 2.14), libcurl3 (>= 7.16.2-1), zlib1g (>= 1:1.1.4)
    Replaces: curl-ssl
    Provides: curl-ssl
    Section: web
    Priority: optional
    Homepage: http://curl.haxx.se
    Description: Get a file from an HTTP, HTTPS or FTP server
     curl is a client to get files from servers using any of the supported
     protocols. The command is designed to work without user interaction
     or any kind of interactivity.
     .
     curl offers a busload of useful tricks like proxy support, user
     authentication, FTP upload, HTTP post, file transfer resume and more.
    Original-Maintainer: Ramakrishnan Muthukrishnan <rkrishnan@debian.org>
    EOS
    deb_file = File.expand_path(File.dirname(__FILE__)+"../../../fixtures/curl_7.22.0-3ubuntu4.11_amd64.deb")
    @instance = Suppository::DpkgDeb.new deb_file
  end
  
  it "package" do
    expect(@instance.attibutes['package']).to eql 'curl'
  end
  
  it "version" do
    expect(@instance.attibutes['version']).to eql '7.22.0-3ubuntu4.11'
  end
  
  it "architecture" do
    expect(@instance.attibutes['architecture']).to eql 'amd64'
  end
  
  it "maintainer" do
    expect(@instance.attibutes['maintainer']).to eql 'Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>'
  end
  
  it "installed_size" do
    expect(@instance.attibutes['installed_size']).to eql '345'
  end
  
  it "depends" do
    expect(@instance.attibutes['depends']).to eql 'libc6 (>= 2.14), libcurl3 (>= 7.16.2-1), zlib1g (>= 1:1.1.4)'
  end
  
  it "replaces" do
    expect(@instance.attibutes['replaces']).to eql 'curl-ssl'
  end
  
  it "provides" do
    expect(@instance.attibutes['provides']).to eql 'curl-ssl'
  end
  
  it "section" do
    expect(@instance.attibutes['section']).to eql 'web'
  end

  it "priority" do
    expect(@instance.attibutes['priority']).to eql 'optional'
  end
  
  it "homepage" do
    expect(@instance.attibutes['homepage']).to eql 'http://curl.haxx.se'
  end
  
  it "description" do
    expect(@instance.attibutes['description']).to eql "Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported\n protocols. The command is designed to work without user interaction\n or any kind of interactivity.\n .\n curl offers a busload of useful tricks like proxy support, user\n authentication, FTP upload, HTTP post, file transfer resume and more.\n"
  end
  
  it "original_maintainer" do
    expect(@instance.attibutes['original_maintainer']).to eql 'Ramakrishnan Muthukrishnan <rkrishnan@debian.org>'
  end
  
 
end


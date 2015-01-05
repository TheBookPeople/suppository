require 'rubygems'
require 'spec_helper'
require 'suppository/package'
require 'suppository/master_deb'

describe Suppository::Package do

EXPECTED_CONTENT = <<-EOS
Package: curl
Version: 7.22.0-3ubuntu4.11
Architecture: amd64
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Installed-Size: 3450
Filename: dists/trusty/internal/binary-amd64/curl_7.22.0-3ubuntu4.11_amd64.deb
Size: 345
MD5sum: e5ca0a9797acda4bfe8404524f0976b3
SHA1: b37ce9b17405d93c323c0b8bbe167c6f2dccfe02
SHA256: 5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555
Section: web
Priority: optional
Description: Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported
 protocols. The command is designed to work without user interaction
 or any kind of interactivity.
 .
 curl offers a busload of useful tricks like proxy support, user
 authentication, FTP upload, HTTP post, file transfer resume and more.


EOS

  before(:each) do
    deb = double(Suppository::MasterDeb)
    @instance = Suppository::Package.new(deb)
    expect(deb).to receive(:package) {'curl'}
    expect(deb).to receive(:dirname) {'dists/trusty/internal/binary-amd64/'}
    expect(deb).to receive(:version) {'7.22.0-3ubuntu4.11'}
    expect(deb).to receive(:architecture) {'amd64'}
    expect(deb).to receive(:maintainer) { 'Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>'}
    expect(deb).to receive(:installed_size) { '3450'}
    expect(deb).to receive(:size) { '345'}
    expect(deb).to receive(:section) {'web'}
    expect(deb).to receive(:priority) {'optional'}
    expect(deb).to receive(:description) {"Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported\n protocols. The command is designed to work without user interaction\n or any kind of interactivity.\n .\n curl offers a busload of useful tricks like proxy support, user\n authentication, FTP upload, HTTP post, file transfer resume and more.\n"}
    expect(deb).to receive(:filename) {'curl_7.22.0-3ubuntu4.11_amd64.deb'}
    expect(deb).to receive(:md5sum) {'e5ca0a9797acda4bfe8404524f0976b3'}
    expect(deb).to receive(:sha1) {'b37ce9b17405d93c323c0b8bbe167c6f2dccfe02'}
    expect(deb).to receive(:sha256) {'5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555'}
  end
    

  it "Outputs the Package" do
    expect(@instance.content).to eql EXPECTED_CONTENT
  end
   
end
  
  
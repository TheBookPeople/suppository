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
MD5sum: e5ca0a9797acda4bfe8404524f0976b3
SHA1: b37ce9b17405d93c323c0b8bbe167c6f2dccfe02
SHA256: 5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555
Section: web
Priority: optional
Homepage: http://www.test.com/
Description: Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported
 protocols. The command is designed to work without user interaction
 or any kind of interactivity.
 .
 curl offers a busload of useful tricks like proxy support, user
 authentication, FTP upload, HTTP post, file transfer resume and more.
Size: 345

EOS

  before(:each) do
    deb = double(Suppository::MasterDeb)
    @instance = Suppository::Package.new('dists/trusty/internal/binary-amd64',deb)
    expect(deb).to receive(:full_attr) {
      [
        ['Package', 'curl'],
        ['Version', '7.22.0-3ubuntu4.11'],
        ['Architecture', 'amd64'],
        ['Maintainer', 'Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>'],
        ['Installed-Size', '3450'],
        ['Filename', 'dists/trusty/internal/binary-amd64/curl_7.22.0-3ubuntu4.11_amd64.deb'],
        ['MD5sum', 'e5ca0a9797acda4bfe8404524f0976b3'],
        ['SHA1', 'b37ce9b17405d93c323c0b8bbe167c6f2dccfe02'],
        ['SHA256', '5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555'],
        ['Section', 'web'],
        ['Priority', 'optional'],
        ['Homepage', 'http://www.test.com/'],
        ['Description', "Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported\n protocols. The command is designed to work without user interaction\n or any kind of interactivity.\n .\n curl offers a busload of useful tricks like proxy support, user\n authentication, FTP upload, HTTP post, file transfer resume and more."],
        ['Size', '345']
      ]
    }
  end
    

  it "Outputs the Package" do
    expect(@instance.content).to eql EXPECTED_CONTENT
  end
   
end
  
  

require 'suppository/dpkg_parser'
require 'pp'

module Suppository
  class Deb
    def initialize(path)
      puts `dpkg-deb -f #{path}`
      @attr = Suppository::DpkgParser.new(`dpkg-deb -f #{path}`).attibutes
    end

    def filename
      "#{@attr['package']}_#{@attr['version']}_#{@attr['architecture']}.deb"
    end

    def method_missing(method_sym, *arguments, &block)
      value = @attr[method_sym.to_s]
      if value
        value
      else
        super
      end
    end

    def respond_to?(method_sym, include_private = false)
      if @attr[method_sym.to_s]
        true
      else
        super
      end
    end
  end
end

require 'suppository/dpkg_deb'

module Suppository
  class Deb
    attr_reader :dirname

    def initialize(path)
      @dirname = File.dirname(path)
      @attr = Suppository::DpkgDeb.new(path).attibutes
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

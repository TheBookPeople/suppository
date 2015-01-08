
module Suppository
  class Package
    def initialize(parent_folder, deb)
      @deb = deb
      @parent_folder = parent_folder
    end

    def content
      @deb.full_attr.to_a.map { |kv_pair| kv_pair.join(': ') }.push("\n").join("\n")
    end

    # private

    # def filename
    #  "#{@parent_folder}/#{@deb.filename}"
    # end
  end
end

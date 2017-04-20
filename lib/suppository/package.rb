
# frozen_string_literal: true

module Suppository
  class Package
    def initialize(parent_folder, deb)
      @deb = deb
      @parent_folder = parent_folder
    end

    def content
      full_attrs = @deb.full_attr
      full_attrs[:Filename] = filename
      full_attrs.sort_by { |k, _v| k == 'Description' ? 1 : 0 }
                .to_a.map { |kv_pair| kv_pair.join(': ') }
                .join("\n") << "\n\n"
    end

    private

    def filename
      "#{@parent_folder}/#{@deb.filename}"
    end
  end
end

module Suppository
  class DpkgDebLine
    DESCRIPTION_FIELD = 'Description'

    attr_reader :attributes

    def initialize(line)
      field = split_line(line)
      if description?(line)
        @attributes = { DESCRIPTION_FIELD => line }
      elsif field
        @attributes = { field['fieldname'] => field['fieldvalue'] }
      else
        fail "can't parse line - '#{line}'"
      end
    end

    private

    def split_line(line)
      /^(?<fieldname>[^:]+): (?<fieldvalue>.+)$/.match(line)
    end

    def description?(line)
      /^ .+$/.match(line)
    end
  end
end

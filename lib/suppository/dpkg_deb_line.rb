module Suppository
  class DpkgDebLine
    DESCRIPTION_FIELD = 'description'

    attr_reader :attributes

    def initialize(line)
      field = split_line(line)
      if description?(line)
        @field = DESCRIPTION_FIELD
        @value = line
      elsif field
        @field = camel_case(field['fieldname'])
        @value = field['fieldvalue']
      else
        fail "can't parse line - '#{line}'"
      end

      @attributes = { @field => @value }
    end

    private

    def split_line(line)
      /^(?<fieldname>[^:]+): (?<fieldvalue>.+)$/.match(line)
    end

    def description?(line)
      /^ .+$/.match(line)
    end

    def camel_case(string)
      string.gsub('-', '_').downcase
    end
  end
end

module Suppository
  class DpkgParser
    attr_reader :attibutes

    def initialize(output)
      @attibutes = parser(output)
    end

    private
    
    def parser(output)
      attibutes = {}
      description = []
      output.each_line do |output_line|
        line = Line.new(output_line)
        if line.field == 'description'
          description.push(line.value)
        else
          attibutes[line.field] = line.value
        end
      end
      attibutes['description'] = description.join('')
      attibutes
    end

    class Line
      attr_reader :field, :value

      def initialize(line)
        field = split_line(line)
        if description?(line)
          @field = 'description'
          @value = line
        elsif field
          @field = camel_case(field['fieldname'])
          @value = field['fieldvalue']
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

      def camel_case(string)
        string.gsub('-', '_').downcase
      end
    end
  end
end

module Suppository
  class Tty
    class << self
      def gray
        bold 30
      end

      def white
        bold 39
      end

      def red
        underline 31
      end

      def reset
        escape 0
      end

      def green
        bold 32
      end

      def em
        underline 39
      end

      private

      def bold(n)
        escape "1;#{n}"
      end

      def underline(n)
        escape "4;#{n}"
      end

      def escape(n)
        "\033[#{n}m" if $stdout.tty?
      end
    end
  end
end

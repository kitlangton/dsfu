require 'yaml'

module Dsfu
  class Size
    include Comparable
    attr_reader :width, :height

    @@sizes = Marshal::load(File.read(File.expand_path('../../../db/sizes_serial', __FILE__)))

    class << self
      def all
        @@sizes
      end
    end

    def initialize(width, height)
      @width, @height = width.to_f, height.to_f
    end

    def <=>(other)
      (width * height) <=> (other.width * other.height)
    end

    def square?
      width == height
    end

    def strip?
      width * 6 < height ||
      width > height * 6
    end
  end
end

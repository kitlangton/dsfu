require 'pathname'

module Dsfu
  class Product
    attr_reader :file_name, :display_name, :height, :width, :description, :price, :category
    attr_accessor :image_path, :company, :category

    def initialize(opts)
      @file_name = opts[:file_name]
      @display_name = opts[:display_name]
      @height = opts[:height]
      @width = opts[:width]
      @price = opts[:price]
      @company = opts[:company] || nil
      @category = opts[:category]
      @description = opts[:description] || nil
      @image_path = opts[:image_path] || nil
    end

    def display_description
      string = []
      string << dimensions
      string << description
      string.join("\n")
    end

    def dimensions
      "#{width}\" x #{height}\""
    end

    def name
      @company + " " + @category + " " + @display_name
    end

    def find_image_path
      self.image_path = File.expand_path(Pathname.glob("#{file_name}")[0].to_path)
    end

    def strip?
      DSFU::Size.new(width, height).strip?
    end
  end
end

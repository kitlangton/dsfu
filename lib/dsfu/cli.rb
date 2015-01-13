require 'thor'
require 'csv'
require 'terminal-table'

module Dsfu
  class CLI < Thor
    desc "view TABLE", "Views a table of products"
    def view_table
      csv = Dir.glob("*.csv")[0]
      products = Dsfu::CsvProductFactory.new(csv).build
      table = products.map.with_index { |product, i| [i, product.display_name, product.dimensions, "$#{product.price}"] }
      puts Terminal::Table.new rows: table, headings: ['ID', 'Display Name', 'Size', 'Price']
    end

    desc "csv", "Creates a new CSV for editing"
    def csv
      CSV.open("product_listing.csv", "wb") do |csv|
        csv << ['File Name', 'Display Name', 'Width', 'Height', 'Price']
      end
      `open product_listing.csv`
    end

    desc "upload COMPANY", "uploads products in directory to the digital store front under COMPANY"
    def upload(company_input)
      csv = Dir.glob("*.csv")[0]
      products = Dsfu::CsvProductFactory.new(csv).build

      Dsfu::SentientStoreFront.execute do
        products.each do |product|
          product.find_image_path
          product.company = company_input
          new_product product
        end
      end
    end
  end
end

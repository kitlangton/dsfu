require 'csv'

module Dsfu
  class CsvProductFactory

    def initialize(csv_file)
      @csv = CSV.read(csv_file, headers: true)
    end

    def build
      products = []
      @csv.each do |product|
        products << Dsfu::Product.new(
          name: product['Display Name'],
          file_name: product['File Name'],
          display_name: product['Display Name'],
          height: product['Height'].to_f,
          width: product['Width'].to_f,
          price: product['Price'].scan(/[\d\.]+/)[0].to_f,
        )
      end
      products
    end

  end
end

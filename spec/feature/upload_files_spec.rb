require 'spec_helper'

describe DSFU do
  Dir.chdir("spec/fixtures")
  csv = Dir.glob("*.csv")[0]
  products = DSFU::CsvProductFactory.new(csv).build
  products[0].find_image_path
  products[0].company = "Whole Foods"
  # p products[0].image_path
  DSFU::SentientStoreFront.execute do
    new_product products[0]
  end
end

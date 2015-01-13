require 'spec_helper'

describe DSFU::CsvProductFactory do
  let(:test_path) { File.expand_path("../../fixtures/sample_product_data.csv", __FILE__)}
  let(:csv) { DSFU::CsvProductFactory.new(test_path) }

  describe "assemble_products" do
    it "returns products" do
      first_product = csv.build[0]
      expected_product = DSFU::Product.new(display_name: "No question is too cheesey (Min 10)",
                                           file_name:"429R_1066296a201_HOL14_Cheese_Cling_FINAL_ToPrintOL_GRACoL",
                                           height: 10.11,
                                           width: 3.91,
                                           price: 7.50)
      expect(first_product.display_name).to eq expected_product.display_name
      expect(first_product.file_name).to eq expected_product.file_name
      expect(first_product.height).to eq expected_product.height
      expect(first_product.width).to eq expected_product.width
      expect(first_product.price).to eq expected_product.price
      expect(first_product).to be_a_kind_of DSFU::Product

      Dir.chdir("spec/fixtures")
      expect(first_product.find_image_path).to eq "429R_1066296a201_HOL14_Cheese_Cling_FINAL_ToPrintOL_GRACoL.txt"
    end

  end

end

module Dsfu
  require 'cgi'
  require 'timeout'
  require 'capybara'

  class SentientStoreFront
    include Capybara::DSL

    LINKS = {
      login_path: "https://coloredge.myprintdesk.net/DSF/",
      new_product_path: "https://coloredge.myprintdesk.net/DSF/Admin/CreateNewCatalogItem.aspx",
      username_input: "ctl00_ctl00_C_W__loginWP__myLogin__userNameTB",
      password_input: "ctl00_ctl00_C_W__loginWP__myLogin__passwordTB",
      product_name_field: "ctl00_ctl00_C_M_txtName",
      display_name_field: "ctl00_ctl00_C_M_ctl00_W_ctl01__StorefrontName",
    }

    def initialize
      Capybara.default_driver = :selenium
    end

    def self.execute(&block)
      dsf = self.new
      dsf.login
      dsf.instance_eval(&block)
    end

    def login
      visit login_path

      fill_in username_input, with: "administrator"
      fill_in password_input, with: "cTKQ&sial4xe"
      click_button "Login"
    end

    def new_product(product)
      visit new_product_path

      fill_in product_name_field, with: product.name
      click_button "Next"

      fill_in display_name_field, with: product.display_name
      find("#ctl00_ctl00_C_M_ctl00_W_ctl01__SKU").native.send_keys "\t#{product.display_description}"

      upload_image(product.image_path)
      change_settings
      add_price(product.price)
      click_button "Next"

      uncheck "ctl00_ctl00_C_M_ctl00_W_ctl02_Fileupload1_OnlyTransferFiles"
      attach_file("ctl00$ctl00$C$M$ctl00$W$ctl02$Fileupload1$htmlInputFileUpload", product.image_path)
      fill_in "ctl00$ctl00$C$M$ctl00$W$ctl02$Fileupload1$TextBoxPageCount", with: "1"
      click_button "Upload File"
      sleep(5)
      click_button "Next"
      select('TF_Duratrans', :from => 'ctl00$ctl00$C$M$ctl00$W$ctl03$TicketTemplates')
      click_button "Finish"
      click_button "Done"
      sleep(1)
    end

    def method_missing (method_name)
      return LINKS[method_name] if LINKS[method_name]
      super
    end

    private

    def add_price(price)
      find(".rtsTxt", text: "Pricing").click
      fill_in "tbl_0_PriceCatalog_regularprice_1", with: price
      fill_in "tbl_0_PriceCatalog_setupprice_1", with: "0"
      page.driver.execute_script "copyTblIPriceCatalog('ctl00_ctl00_C_M_ctl00_W_ctl01_GridViewPricesheets_ctl02_PriceItemFrame_ctl17','ctl00_ctl00_C_M_ctl00_W_ctl01_GridViewPricesheets_ctl02_PriceItemFrame_imageplushid_PriceCatalog','tbl_0_PriceCatalog','','', 'PriceCatalog');"
      page.driver.execute_script "pasteallIPriceCatalog();"
    end

    def change_settings
      find(".rtsTxt", text: "Settings").click
      choose "ctl00_ctl00_C_M_ctl00_W_ctl01_AllowBuyerConfigurationRadioButton_1"
      uncheck "ctl00_ctl00_C_M_ctl00_W_ctl01_FinalWdHt_ChkAllowCustom"
    end

    def upload_image(image_path)
      within "#ctl00_ctl00_C_M_ctl00_W_ctl01__BigIconByItself_ProductIconImageAndButtonRow" do
        click_button "Edit"
      end
      choose "ctl00_ctl00_C_M_ctl00_W_ctl01__BigIconByItself_ProductIcon_rdbUploadIcon"
      check "ctl00_ctl00_C_M_ctl00_W_ctl01__BigIconByItself_ProductIcon_ChkUseSameImageIcon"
      attach_file("ctl00$ctl00$C$M$ctl00$W$ctl01$_BigIconByItself$ProductIcon$_uploadedFile$ctl01", image_path)
      click_button "Upload"
    end
  end
end

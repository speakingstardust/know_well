require "rails_helper"
require "pry"

RSpec.describe "SDS Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let(:product) { create(:product) }
    it "allows a user to create an SDS" do 
      visit new_product_safety_data_sheet_path(product)

      attach_file "SDS Pdf", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect { 
        click_on "Create Safety data sheet"
      }.to change(SafetyDataSheet, :count).by(1)

      @sds = SafetyDataSheet.where(product: product).first

      expect(page).to have_current_path(product_safety_data_sheet_path(product, @sds))

      visit safety_data_sheets_path

      expect(page).to have_content(product.name)
      expect(page).to have_content(product.manufacturer.name)
    end
  end
  describe "Edit" do 
    let(:sds) { create(:safety_data_sheet) }
    xit "allows a user to edit an existing SDS" do 
      visit edit_safety_data_sheet_path(sds)

      fill_in "Product name", with: "Different Product Name" 
      fill_in "Manufacturer name", with: "Different Manufacturer Name" 
      select "Meico Products", from: "Category"
      click_on "Update Safety data sheet"

      expect(page).to have_current_path(safety_data_sheet_path(sds))
      expect(page).to have_content("Different Product Name") 
      expect(page).to have_content("Different Manufacturer Name") 
      expect(page).to have_content("Meico Products")
    end
  end
end

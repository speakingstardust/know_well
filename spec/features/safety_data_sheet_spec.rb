require "rails_helper"
require "pry"

RSpec.describe "SDS Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    it "allows a user to create an SDS" do 
      visit new_safety_data_sheet_path

      fill_in "Product name", with: "Test Product"
      fill_in "Manufacturer name", with: "Test Manufacturer"
      select "Used In House", from: "Category"
      attach_file "SDS Pdf", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect { 
        click_on "Create Safety data sheet"
      }.to change(SafetyDataSheet, :count).by(1)

      @sds = SafetyDataSheet.where(product_name: "Test Product").first

      expect(page).to have_current_path(safety_data_sheet_path(@sds))

      visit safety_data_sheets_path

      expect(page).to have_content("Test Product")
      expect(page).to have_content("Test Manufacturer")
    end
  end
  describe "Edit" do 
    let(:sds) { create(:safety_data_sheet) }
    it "allows a user to edit an existing SDS" do 
      visit edit_safety_data_sheet_path(sds)

      fill_in "Product name", with: "Different Product Name" 
      fill_in "Manufacturer name", with: "Different Manufacturer Name" 
      select "MEICO Products", from: "Category"
      click_on "Update Safety data sheet"

      expect(page).to have_current_path(safety_data_sheet_path(sds))
      expect(page).to have_content("Different Product Name") 
      expect(page).to have_content("Different Manufacturer Name") 
      expect(page).to have_content("MEICO Products")
    end
  end
end

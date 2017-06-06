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
      select "Used in House", from: "Category"
      attach_file "SDS_Grate.pdf", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect { 
        click_on "Create Safety Data Sheet"
      }.to change(SafetyDataSheet, :count).by(1)

      @sds = SafetyDataSheet.find_by_name("Test Product")

      expect(page).to have_current_path(safet_data_sheet_path(@sds))

      visit safety_data_sheets_path

      expect(page).to have_content("Test Product")
      expect(page).to have_content("Test Manufacturer")
    end
  end
end

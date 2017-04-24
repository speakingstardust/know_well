require "rails_helper"
require "pry"

RSpec.describe "Manufacturer Management", type: :feature do

  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end
  
  describe "Create" do 
    it "allows a user to create a manufacturer" do
      visit new_manufacturer_path
      fill_in "Name", with: "Test Manufacturer" 
      fill_in "Website", with: "www.testmanufacturer.com"
      fill_in "Phone", with: "555-555-5555"
      click_on "Create Manufacturer" 
      @manufacturer = Manufacturer.find_by_name("Test Manufacturer")
      binding.pry

      expect(page).to have_current_path(manufacturer_path(@manufacturer))

      visit manufacturers_path
      expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .name", text: "Test Manufacturer") 
      expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .website", text: "www.testmanufacturer.com")
      expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .phone", text: "555-555-5555") 
    end
  end
end

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

      expect(page).to have_current_path(manufacturer_path(@manufacturer))

      visit manufacturers_path
      expect(page).to have_content("Test Manufacturer")
      expect(page).to have_css("a", text: "Test Manufacturer's Website")
      expect(page).to have_content("555-555-5555")
    end
  end

  describe "Edit" do 
    it "allows a user to edit an existing manufacturer" do 
      @manufacturer = FactoryGirl.create(:manufacturer)

      visit edit_manufacturer_path(@manufacturer)
      fill_in "Name", with: "New Manufacturer Name"
      fill_in "Website", with: "new.manufacturer.com"
      fill_in "Phone", with: "888-888-8888"
      click_on "Update Manufacturer" 

      expect(page).to have_current_path(manufacturer_path(@manufacturer))

      visit manufacturers_path
      expect(page).to have_content("New Manufacturer Name")
      expect(page).to have_css("a", text: "New Manufacturer Name's Website")
      expect(page).to have_content("888-888-8888")
    end
  end

  describe "Destroy" do
    it "allows a user to destroy an existing manufacturer", js: true do
      @manufacturer = FactoryGirl.create(:manufacturer)

      visit manufacturers_path
      click_link "Destroy"
      page.accept_alert "Are you sure?" do 
        click_button 'Ok'
      end

      expect(page).to_not have_content(@manufacturer.name)
    end
  end
end
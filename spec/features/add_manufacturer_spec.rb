require "rails_helper"

describe "add manufacturer", type: :controller do 

  login_user

  it "allows a user to create a manufacturer" do 
    visit new_manufacturer_path
    fill_in "Name", with: "Test Manufacturer" 
    fill_in "Website", with: "www.testmanufacturer.com"
    fill_in "Phone", with: "555-555-5555"
    click_on "Create Manufacturer" 

    visit manufacturers_path
    @manufacturer = Manufacturer.find_by_name("Test Manufacturer")
    expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .name", text: "Test Manufacturer") 
    expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .website", text: "www.testmanufacturer.com")
    expect(page).to have_selector("#manufacturer_#{@manufacturer.id} .phone", text: "555-555-5555") 
  end
end

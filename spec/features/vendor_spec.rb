require "rails_helper"
require "pry"

RSpec.describe "Vendor Management", type: :feature do 

  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

 describe "Create" do 
  it "allows a user to create a vendor" do 
    visit new_vendor_path
    fill_in "Name", with: "Test Vendor" 
    fill_in "Website", with: "www.testvendor.com"
    fill_in "Phone", with: "555-555-5555"
    
    expect {
      click_on "Create Vendor"
    }.to change(Vendor, :count).by(1)

    @vendor = Vendor.find_by_name("Test Vendor")

    expect(page).to have_current_path(vendor_path(@vendor))

    visit vendors_path
    
    expect(page).to have_content("Test Vendor")
    expect(page).to have_css("a", text: "Test Vendor's Website")
    expect(page).to have_content("555-555-5555")
  end
 end 
  
end

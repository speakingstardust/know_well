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

  describe "Show" do 
    it "allows a user to show the details of a vendor" do
      @vendor = FactoryGirl.create(:vendor)

      visit vendors_path
      expect(page).to have_content(@vendor.name)

      within_table("vendors-table") do
        click_on "Show"
      end

      expect(page).to have_current_path(vendor_path(@vendor))
      expect(page).to have_content(@vendor.name)
      expect(page).to have_css("a", text: "#{@vendor.name}'s Website")
      expect(page).to have_content(@vendor.phone)
    end
  end

  describe "Edit" do 
    it "allows a user to edit a vendor's attributes" do
      @vendor = FactoryGirl.create(:vendor)

      visit vendors_path
      expect(page).to have_content(@vendor.name)

      within_table("vendors-table") do
        click_on "Edit"
      end

      expect(page).to have_current_path(edit_vendor_path(@vendor))

      fill_in "Name", with: "New Vendor Name" 
      fill_in "Website", with: "new.vendor.com"
      fill_in "Phone", with: "888-888-8888"
      click_on "Update Vendor"

      expect(page).to have_current_path(vendor_path(@vendor))
      expect(page).to have_content("New Vendor Name")
      expect(page).to have_css("a", text: "New Vendor Name's Website")
      expect(page).to have_content("888-888-8888")
    end
  end
  
end

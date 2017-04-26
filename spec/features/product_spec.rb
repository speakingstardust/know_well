require "rails_helper"
require "pry"

RSpec.describe "Product Mangement", type: :feature do 
  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do
    it "allows a user to create a product" do 
      @vendor = FactoryGirl.create(:vendor)
      @manufacturer = FactoryGirl.create(:manufacturer)

      visit new_product_path
      fill_in "Name", with: "Test Product"
      fill_in "Part Number", with: "12345" 
      select "Consumables", from: "Category"
      select @vendor.name, from: "Vendor"
      select @manufacturer.name, from: "Manufacturer" 
      fill_in "Description", with: "Test product description" 
      fill_in "product[container]", with: "case"
      fill_in "product[unit]", with: "pair"
      fill_in "Units Per Container", with: 24
      fill_in "Price Per Container", with: 4.50 
      fill_in "Maximum On Hand", with: 6.0
      fill_in "Minimum On Hand", with: 1.5 
      fill_in "Lead Time", with: 14 
      fill_in "Current Amount On Hand", with: 3.5
      expect {
        click_on "Create Product"
      }.to change(Product, :count).by(1)

      @product = Product.find_by_name("Test Product")

      expect(page).to have_current_path(product_path(@product))

      visit products_path

      expect(page).to have_content("Test Product")
      expect(page).to have_css("a", @vendor.name) 
      expect(page).to have_css("a", @manufacturer.name)
      expect(page).to have_content("12345")
      expect(page).to have_content("case")
      expect(page).to have_content("pair")
    end
  end
end

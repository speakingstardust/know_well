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
      expect(page).to have_content("12345")
      expect(page).to have_content(6.0)
      expect(page).to have_content(1.5)
    end
  end

  describe "Show" do 
    let(:product) { FactoryGirl.create(:product) }
    let(:vendor) { product.vendor }
    let(:manufacturer) { product.manufacturer }

    it "allows a user to show the details of a product" do 
      product

      visit products_path 
      expect(page).to have_content(product.name)

      within_table("products-table") do
        click_on "Show"
      end

      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content(product.name)
      expect(page).to have_link(vendor.name, href: vendor_path(vendor))
      expect(page).to have_link(manufacturer.name, href: manufacturer_path(manufacturer))
      expect(page).to have_content(product.description)
      expect(page).to have_content(product.container)
      expect(page).to have_content(product.unit)
      expect(page).to have_content(product.units_per_container)
    end
  end

  describe "Edit" do 
    let(:product) { FactoryGirl.create(:product) }
    
    it "allows a user to edit the details of a product" do
      product 

      visit products_path 
      expect(page).to have_content(product.name)

      within_table("products-table") do 
        click_on "Edit"
      end

      expect(page).to have_current_path(edit_product_path(product))

      fill_in "Name", with: "New Name" 
      fill_in "Lead Time", with: 7 
      click_on "Update Product"

      expect(page).to have_current_path(product_path(product))
      expect(page).to have_content("New Name")
      expect(page).to have_content(7)
    end
  end

  describe "Destroy" do 
    let(:product) { FactoryGirl.create(:product) }

    it "allows a user to destroy a product" do 
      product

      visit products_path
      expect(page).to have_content(product.name)

      within_table("products-table") do
        expect {
          click_on "Destroy"
        }.to change(Product, :count).by(-1)
      end

      expect(page).to_not have_content(product.name)
    end
  end
end

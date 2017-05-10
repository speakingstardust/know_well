require "rails_helper"
require "pry"

RSpec.describe "Product Mangement", type: :feature do 
  before(:each) do
    user = FactoryGirl.create(:user)
    user.add_role :inventory_control
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

  describe "Count" do 
    let(:first_product) { FactoryGirl.create(:product, name: "First Product") }
    let(:second_product) { FactoryGirl.create(:product, name: "Second Product", vendor: first_product.vendor, manufacturer: first_product.manufacturer) }
    let(:third_product) { FactoryGirl.create(:product, name: "Third Product", vendor: first_product.vendor, manufacturer: first_product.manufacturer) }


    it "allows a user to make counts of products based on category" do
      first_product
      second_product
      third_product

      visit product_count_path
      select "Lab supplies", from: "Category"
      click_on "Filter"

      expect(page).to have_content(first_product.name)
      expect(page).to have_content(second_product.name)
      expect(page).to have_content(third_product.name)
    
      within_table("product-table") do

        within("td##{first_product.id}") do
          fill_in "products[#{first_product.id}][current_on_hand]", with: 6 
        end

        within("td##{second_product.id}") do
          fill_in "products[#{second_product.id}][current_on_hand]", with: 6 
        end
        
        within("td##{third_product.id}") do
          fill_in "products[#{third_product.id}][current_on_hand]", with: 6 
        end

      end

      click_on "Save changes"

      expect(page).to have_current_path(products_path)
      expect(page).to have_content(first_product.name)
      expect(page).to have_content(second_product.name)
      expect(page).to have_content(third_product.name)
      expect(page).to have_content(6)
    end
  end
end

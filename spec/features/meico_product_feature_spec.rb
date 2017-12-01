require "rails_helper"
require "pry"

RSpec.describe "MEICO Product Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    it "allows a user to create a MEICO Product" do 
      visit new_meico_product_path
      fill_in "Name", with: "Test MEICO Product"
      expect {
        click_on "Create Meico product"
      }.to change(MeicoProduct, :count).by(1)

      @meico_product = MeicoProduct.find_by_name("Test MEICO Product")

      expect(page).to have_current_path(meico_product_path(@meico_product))
      expect(page).to have_content(@meico_product.name)
    end
  end

  describe "Edit" do 
    let!(:meico_product) { FactoryGirl.create(:meico_product) }
    it "allows a user to edit an existing MEICO Product" do 
      visit edit_meico_product_path(meico_product)
      fill_in "Name", with: "Blah Blah Blah"
      click_on "Update Meico product"

      expect(page).to have_current_path(meico_product_path(meico_product))
      expect(page).to have_content("Blah Blah Blah")
    end
  end

  describe "Index" do 
    let!(:meico_product) { FactoryGirl.create(:meico_product) }
    it "allows a user to navigate through an index of MEICO Products" do
      visit meico_products_path

      expect(page).to have_content(meico_product.name)
      click_on "Show"

      expect(page).to have_current_path(meico_product_path(meico_product))
    end
  end

  describe "Create Document" do 
    let!(:meico_product) { FactoryGirl.create(:meico_product) }
    it "allows a user to create a document from a MEICO Product show view" do 
      visit meico_product_path(meico_product)

      click_on "Create New Document"

      expect(page).to have_current_path(new_meico_product_document_path(meico_product.id))

      fill_in "Name", with: "Test MEICO Product SDS"
      fill_in "Version", with: "1.0"
      select "SDS", from: "Category"
      select Date.today.year, from: "document_date_issued_1i"
      select Date.today.strftime("%B"), from: "document_date_issued_2i"
      select Date.today.day, from: "document_date_issued_3i"
      attach_file "File", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect { 
        click_on "Create Document"
      }.to change(Document, :count).by(1)

      @document = Document.find_by_name("Test MEICO Product SDS")

      expect(page).to have_current_path(meico_product_document_path(meico_product.id, @document.id))
      expect(page).to have_content(@document.name)
      expect(page).to have_content(@document.version)
      expect(page).to have_content(@document.category)
      expect(page).to have_content(Date.today.strftime("%m/%d/%Y"))
    end
  end
end

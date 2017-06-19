require "rails_helper"
require "pry"

RSpec.describe "SDS Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let(:product) { create(:product) }
    it "allows a user to create an SDS" do 
      visit new_product_safety_data_sheet_path(product)

      attach_file "SDS Pdf", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect { 
        click_on "Create Safety data sheet"
      }.to change(SafetyDataSheet, :count).by(1)

      expect(page).to have_current_path(product_path(product))

      visit safety_data_sheets_path

      expect(page).to have_content(product.name)
      expect(page).to have_content(product.manufacturer.name)
    end
  end
  describe "Edit" do 
    let(:sds) { create(:safety_data_sheet) }
    it "allows a user to edit an existing SDS" do 
      visit edit_product_safety_data_sheet_path(sds.product, sds)

      attach_file "SDS Pdf", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      click_on "Update Safety data sheet"

      expect(page).to have_current_path(product_path(sds.product))
      expect(page).to have_content(sds.product.name) 
      expect(page).to have_content(sds.product.manufacturer.name) 
      expect(page).to have_content(sds.pdf)
    end
  end
end

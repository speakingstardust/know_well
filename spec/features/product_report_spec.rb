require "rails_helper"
require "pry"

RSpec.describe "Product Report Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    user.add_role :inventory_control
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let!(:raw_material) { FactoryGirl.create(:product, category: create(:category, 
                                                                        name: "Raw Materials"), 
                                                                        name: "Raw Material") }
    let!(:lab_supply) { FactoryGirl.create(:product, category: create(:category, 
                                                                      name: "Lab Supplies"), 
                                                                      name: "Lab Supply") }
    let!(:consumable) { FactoryGirl.create(:product, category: create(:category, 
                                                                      name: "Consumables"), 
                                                                      name: "Consumable") }
    let!(:shop_supplies) { FactoryGirl.create(:product, category: create(:category, 
                                                                         name: "Shop Supplies"), 
                                                                         name: "Shop Supply") }

    it "allows a user to create a product report and see it after" do 
      visit new_product_report_path

      check "Raw Materials"
      check "Lab Supplies" 
      check "Consumables" 
      fill_in "Notes", with: "Testing product report creation notes" 

      expect { 
        click_on "Create Product Report" 
      }.to change(ProductReport, :count).by(1)

      @product_report = ProductReport.first

      expect(page).to have_current_path(product_report_path(@product_report))

      expect(page).to have_content(raw_material.name)
      expect(page).to have_content(raw_material.current_on_hand)
      expect(page).to have_content(lab_supply.name)
      expect(page).to have_content(consumable.name)
      expect(page).to have_content("Testing product report creation notes")
    end
  end
end

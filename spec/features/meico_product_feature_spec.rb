require "rails_helper"
require "pry"

RSpec.describe "MEICO Product Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    it "allows a user to create a MEICO Product" do 
      visit new_product_path
      fill_in "Name", with: "Test MEICO Product"
      expect {
        click_on "Create Meico product"
      }.to change(MeicoProduct, :count).by(1)

      @meico_product = MeicoProduct.find_by_name("Test MEICO Product")

      expect(page).to have_current_path(meico_product_path(@meico_product))
      expect(page).to have_content(@meico_product.name)
    end
  end

end

require "rails_helper"
require "pry"

RSpec.describe "MEICO Product Document Management", type: :feature do 
  before(:each) do 
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  describe "Edit" do 
    let!(:meico_product) { FactoryGirl.create(:meico_product) }
    let!(:document) { FactoryGirl.create(:document, meico_product: meico_product, updated_by: nil) }
    it "allows a user to edit a document" do 
      visit edit_meico_product_document_path(meico_product.id, document.id)

      fill_in "Name", with: "Edited Test MEICO Product Name"
      click_on "Update Document"

      document.reload

      expect(page).to have_current_path(meico_product_document_path(meico_product.id, document.id))
      expect(page).to have_content("Edited Test MEICO Product Name")
      expect(document.updated_by).to eq("#{@user.full_name}")
    end
  end
end

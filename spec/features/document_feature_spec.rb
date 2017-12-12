require "rails_helper"
require "pry"

RSpec.describe "MEICO Product Document Management", type: :feature do 
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @user.add_role :lab_supervisor
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

  describe "Destroy" do 
    let!(:meico_product) { FactoryGirl.create(:meico_product) }
    let!(:document) { FactoryGirl.create(:document, meico_product: meico_product) }
    it "allows a user to destroy a document" do 
      visit meico_product_path(meico_product)

      expect(page).to have_content(document.name)
      expect(page).to have_content(document.version)
      
      expect {
        click_on "Destroy"
      }.to change(Document, :count).by(-1)

      expect(page).to_not have_content(document.name)

    end
  end

  describe "Email" do 
    let!(:document) { FactoryGirl.create(:document) }
    let!(:customer) { FactoryGirl.create(:customer) }

    it "allows a user to send an email" do 
      visit meico_product_path(document.meico_product)

      expect(page).to have_content(document.name)

      click_on "Share"

      expect(page).to have_current_path(new_document_mail_log_path(document_id: document.id))
      
      fill_in "Email", with: "test@ing.com"
      fill_in "Purpose", with: "Test purpose"
      select customer.name, from: "Customer"
      expect {
        click_on "Share Document"
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
      
      expect(page).to have_current_path(meico_product_path(document.meico_product))
    end
  end
end

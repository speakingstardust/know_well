require 'rails_helper'
require 'pry'

RSpec.describe "Customer Contact Management", type: :feature do 
  before :each do 
    @user = FactoryGirl.create(:user)
    @user.add_role :bookkeeper
    login_as @user, scope: :user
  end

  describe "Create" do 
    let!(:customer) { FactoryGirl.create(:customer) }

    it "allows a user to create a new customer contact" do 
      visit customer_path(customer)

      click_on "Create New Contact"

      expect(page).to have_current_path(new_customer_contact_path(customer))

      select "Primary Billing", from: "Kind"
      fill_in "First name", with: "Steve"
      fill_in "Last name", with: "Jobs"
      fill_in "Phone", with: "5555555555"
      fill_in "Fax", with: "5555555555"
      fill_in "Email", with: "steve@apple.com"
      fill_in "Note", with: "Testing the notes"
      expect {
        click_on "Create Contact"
      }.to change(Contact, :count).by(1)

      @contact = Contact.find_by_first_name("Steve")

      expect(page).to have_current_path(customer_contact_path(customer, @contact))
      expect(page).to have_content(@contact.first_name)
      expect(page).to have_content(@contact.last_name)
      expect(page).to have_content(@contact.phone)
      expect(page).to have_content(@contact.fax)
      expect(page).to have_content(@contact.email)
      expect(page).to have_content(@contact.note)
    end
  end
end

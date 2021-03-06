require 'rails_helper'
require 'pry'

RSpec.describe "Jig Management", type: :feature do 
  def login_shop_supervisor
    shop_supervisor = FactoryGirl.create(:user)
    shop_supervisor.add_role(:shop_supervisor)
    login_as(shop_supervisor, :scope => :user)
  end

  def login_bookkeeper
    bookkeeper = FactoryGirl.create(:user, email: "bookkeeper@test.com") 
    bookkeeper.add_role(:bookkeeper)
    login_as(bookkeeper, :scope => :user)
  end

  before(:each) do 
    @customer = create(:customer)
  end

  describe "Create" do 
    it "allows a shop supervisor to create a jig" do 
      login_shop_supervisor

      visit new_jig_path

      fill_in "Name", with: "Test Jig" 
      select @customer.name, from: "Customer" 
      fill_in "Special Considerations or Requirments", with: "Test jig notes"
      expect {
        click_on "Create Jig"
      }.to change(Jig, :count).by(1)

      @jig = Jig.find_by_name("Test Jig")

      expect(page).to have_current_path(jig_path(@jig))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(@customer.name)
      expect(page).to have_content(@jig.note)
    end

    it "allows a bookkeeper to create a jig with prices" do 
      login_bookkeeper

      visit new_jig_path

      fill_in "Name", with: "Test Jig" 
      select @customer.name, from: "Customer" 
      fill_in "Cleaning charge", with: 9.50
      fill_in "Repair charge", with: 6.50
      expect {
        click_on "Create Jig"
      }.to change(Jig, :count).by(1)

      @jig = Jig.find_by_name("Test Jig")

      expect(page).to have_current_path(jig_path(@jig))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(@customer.name)
      expect(page).to have_content(@jig.cleaning_charge)
      expect(page).to have_content(@jig.repair_charge)
    end 
  end 

  describe "Edit" do 
    it "allows a shop supervisor to edit a jig" do 
      @jig = create(:jig, customer: @customer) 
      login_shop_supervisor

      visit edit_jig_path(@jig)

      fill_in "Name", with: "Edited Test Jig Name" 
      click_on "Update Jig" 

      @jig.reload

      expect(page).to have_current_path(jig_path(@jig))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(@customer.name)
      expect(page).to_not have_content(@jig.cleaning_charge)
      expect(page).to_not have_content(@jig.repair_charge)
    end

    it "allows a bookeeper to edit a jig" do 
      @jig = create(:jig, customer: @customer) 
      login_bookkeeper

      visit edit_jig_path(@jig)

      fill_in "Name", with: "Edited Test Jig Name" 
      fill_in "Cleaning charge", with: 12.50
      fill_in "Repair charge", with: 10.50
      click_on "Update Jig" 

      @jig.reload

      expect(page).to have_current_path(jig_path(@jig))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(@customer.name)
      expect(page).to have_content(@jig.cleaning_charge)
      expect(page).to have_content(@jig.repair_charge)
    end
  end
end

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
      expect {
        click_on "Create jig"
      }.to change(Jig, :count).by(1)

      @jig = Jig.find_by_name("Test Jig")

      expect(page).to have_current_path(jig_path(@jig))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(@customer.name)
    end
  end 
end

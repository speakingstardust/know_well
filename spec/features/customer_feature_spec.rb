require 'rails_helper'
require 'pry'

RSpec.describe "Customer Management", type: :feature do 
  before :each do 
    @user = FactoryGirl.create :user
    @user.add_role :shop_supervisor
    login_as @user, scope: :user
  end

  describe "Create" do 
    it "allows a user to create a new customer" do 
      visit new_customer_path 

      fill_in "Name", with: "Test Business Name" 
      fill_in "Phone", with: "5555555555"
      fill_in "Fax", with: "5555555555"
    end
  end 
end

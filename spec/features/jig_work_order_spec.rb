require 'rails_helper'
require 'pry'

RSpec.describe "Jig Work Order Management", type: :feature do 

  def login_shop_supervisor
    shop_supervisor = FactoryGirl.create(:user)
    shop_supervisor.add_role(:shop_supervisor)
    login_as(shop_supervisor, :scope => :user)
  end

  def login_bookkeeper
    bookkeeper = FactoryGirl.create(:user) 
    bookkeeper.add_role(:bookkeeper)
    login_as(bookkeeper, :scope => :user)
  end

  describe "Create" do 
    it "allows a bookkeeper to create a Jig Work Order" do 
      @customer = FactoryGirl.create(:customer) 
      @jig = FactoryGirl.create(:jig, customer: @customer) 

      login_bookkeeper

      visit work_orders_management_path
      select @customer.name, from: "customer_customer_id" 
      click_on "Jig Work Order"

      expect(page).to have_current_path(new_jig_work_order_path, only_path: true)

      select Date.today.year, from: "jig_work_order_pickup_date_1i"
      select Date.today.month, from: "jig_work_order_pickup_date_2i"
      select Date.today.day, from: "jig_work_order_pickup_date_3i"
      fill_in "Pickup Time", with: "AM"
      fill_in "Notes", with: "Test Jig Work Order notes"
      select @jig.name, from: "jig_work_order_jig_work_order_line_items_attributes_0_jig_id"
      fill_in "jig_work_order_jig_work_order_line_items_attributes_0_expected", with: 5
      
      expect {
        click_on "Create Jig work order" 
      }.to change(JigWorkOrder, :count).by(1)

      @jig_work_order = JigWorkOrder.first

      expect(page).to have_current_path(jig_work_order_path(@jig_work_order))
      expect(page).to have_content(@jig.name)
      expect(page).to have_content(5)
      expect(page).to have_content(@customer.name)
      expect(page).to have_content(@jig_work_order.id)
      expect(page).to have_content(Date.today)
    end
  end
end

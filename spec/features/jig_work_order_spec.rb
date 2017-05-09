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

  def setup_jig_work_order
    @jig_work_order = JigWorkOrder.new(pickup_date: Date.today - 5, customer: @customer)
    jig_work_order_line_item = JigWorkOrderLineItem.create(jig: @jig, expected: 5, jig_work_order: @jig_work_order)
    @jig_work_order.jig_work_order_line_items << jig_work_order_line_item 
    @jig_work_order.save
  end

  before(:each) do 
    @customer = FactoryGirl.create(:customer) 
    @jig = FactoryGirl.create(:jig, customer: @customer) 
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
      select Date.today.strftime("%B"), from: "jig_work_order_pickup_date_2i"
      select Date.today.day, from: "jig_work_order_pickup_date_3i"
      fill_in "Pickup time", with: "AM"
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
      expect(page).to have_content(Date.today.strftime("%m/%d/%Y"))
    end
  end

  describe "Edit" do 
    it "allows a shop supervisor to edit a jig work order" do 
      setup_jig_work_order

      @second_jig = FactoryGirl.create(:jig, customer: @customer)

      login_shop_supervisor

      visit edit_jig_work_order_path(@jig_work_order)

      select Date.today.year, from: "jig_work_order_returned_1i"
      select Date.today.strftime("%B"), from: "jig_work_order_returned_2i"
      select Date.today.day, from: "jig_work_order_returned_3i"
      fill_in "Return time", with: "PM"
      select @second_jig.name, from: "jig_work_order_jig_work_order_line_items_attributes_0_jig_id"
      fill_in "jig_work_order_jig_work_order_line_items_attributes_0_repaired", with: 3
      fill_in "jig_work_order_jig_work_order_line_items_attributes_0_actual", with: 10
      click_on "Update Jig work order" 

      expect(page).to have_current_path(jig_work_order_path(@jig_work_order))
      expect(page).to have_content(@second_jig.name)
      expect(page).to have_content(3)
      expect(page).to have_content(10)
      expect(page).to have_content(Date.today.strftime("%m/%d/%Y"))
    end
  end

  describe "Manage State" do 
    it "allows a shop supervisor to receive a jig work order after it is created" do 
      setup_jig_work_order 
      @jig_work_order.open!
      
      login_shop_supervisor
      visit jig_work_order_path(@jig_work_order)

      expect(page).to have_css('a', text: "Receive")
      click_on "Receive"

      @jig_work_order.reload
      expect(@jig_work_order).to have_state(:received)
    end
  end
end

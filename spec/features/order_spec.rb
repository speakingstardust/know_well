require "rails_helper"
require "pry"

RSpec.describe "Order Management", type: :feature do 
  before(:each) do
    user = FactoryGirl.create(:user)
    user.add_role :inventory_control
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let(:category) { FactoryGirl.create(:category) }
    let!(:tool_category) { FactoryGirl.create(:category, name: "Tool") }
    let!(:equipment_category) { FactoryGirl.create(:category, name: "Equipment") }
    let!(:vehicle_category) { FactoryGirl.create(:category, name: "Vehicle") }
    let!(:at_min_product) { FactoryGirl.create(:product, current_on_hand: 24.0, category: category) } 
    let!(:above_min_product) { FactoryGirl.create(:product, current_on_hand: 36.0, category: category) }
    let!(:below_min_product) { FactoryGirl.create(:product, current_on_hand: 12.0, category: category) }
    
    it "allows a user to create an order and to see details of order after" do 
      visit new_order_path

      expect(page).to have_content(at_min_product.name) 
      expect(page).to have_content(below_min_product.name)
      expect(page).to have_content(below_min_product.category.name)
      expect(page).to have_content(at_min_product.current_on_hand)
      expect(page).to have_content(at_min_product.lead_time)      
      expect(page).to have_content(at_min_product.category.name)

      check at_min_product.name
      check below_min_product.name

      expect {
        click_on "Create Order"
      }.to change(Order, :count).by(1)

      @order = Order.first

      expect(page).to have_current_path(order_path(@order))

      expect(page).to have_content(@order.id)
      expect(page).to have_content(at_min_product.name)
      expect(page).to have_content(2)
      expect(page).to have_content(below_min_product.name)
      expect(page).to have_content(3)
    end
  end

  describe "Index" do 
    let!(:first_order) { FactoryGirl.create(:order_with_line_items) } 
    let!(:second_order) { FactoryGirl.create(:order_with_line_items) }

    it "allows a user to navigate to the orders list" do 
      visit orders_path

      expect(page).to have_content(first_order.id)
      expect(page).to have_content(second_order.id)
      expect(page).to have_content(3)
    end
  end
  
end

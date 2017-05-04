require "rails_helper"
require "pry"

RSpec.describe "Order Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let(:at_min_product) { FactoryGirl.create(:product, current_on_hand: 1.5) } 
    let(:above_min_product) { FactoryGirl.create(:product, current_on_hand: 3) }
    let(:below_min_product) { FactoryGirl.create(:product, current_on_hand: 1) }
    
    it "allows a user to create an order" do 
      @at_min_product = at_min_product
      @above_min_product = above_min_product
      @below_min_product = below_min_product 
      
      visit new_order_path

      expect(page).to have_content(@at_min_product.name) 
      expect(page).to have_content(@below_min_product.name)
      expect(page).to have_content(@at_min_product.current_on_hand)
      expect(page).to have_content(@at_min_product.lead_time)      

      check @at_min_product.name
      check @below_min_product.name
      expect {
        click "Create Order"
      }.to change(Order, :count).by(1)

      @order = Order.first

      expect(page).to have_current_path(order_path(@order))

      visit orders_path

      expect(page).to have_content(@order.date_created)
    end
  end
end

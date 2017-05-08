require "rails_helper"
require "pry"

RSpec.describe "Order Management", type: :feature do 
  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    let!(:at_min_product) { FactoryGirl.create(:product, current_on_hand: 24.0) } 
    let!(:above_min_product) { FactoryGirl.create(:product, current_on_hand: 36.0) }
    let!(:below_min_product) { FactoryGirl.create(:product, current_on_hand: 12.0) }
    
    it "allows a user to create an order" do 
      visit new_order_path

      expect(page).to have_content(at_min_product.name) 
      expect(page).to have_content(below_min_product.name)
      expect(page).to have_content(at_min_product.current_on_hand)
      expect(page).to have_content(at_min_product.lead_time)      

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
end

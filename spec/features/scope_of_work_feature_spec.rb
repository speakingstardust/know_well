require "rails_helper"
require "pry"

RSpec.describe "Scope of Work Management", type: :feature do 
  before(:each) do 
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  describe "Create" do 
    let!(:customer) { FactoryGirl.create(:customer) }

    it "allows a user to create a scope of work for a customer" do 
      visit new_scope_of_work_path

      fill_in "Name", with: "Test Scope of Work"
      fill_in "Created by", with: "Joe Blow"
      select Date.today.year, from: "scope_of_work_date_created_1i"
      select Date.today.strftime("%B"), from: "scope_of_work_date_created_2i"
      select Date.today.day, from: "scope_of_work_date_created_3i"
      fill_in "Description", with: "Test description of this scope of work"
      select customer.name, from: "Customer"
      attach_file "File", "#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf"
      expect {
        click_on "Create Scope of work"
      }.to change(ScopeOfWork, :count).by(1)

      @scope_of_work = ScopeOfWork.find_by_name("Test Scope of Work")

      expect(page).to have_current_path(scope_of_work_path(@scope_of_work))
      expect(page).to have_content(@scope_of_work.name)
      expect(page).to have_content(@scope_of_work.created_by)
      expect(page).to have_content(@scope_of_work.description)
      expect(page).to have_content(@scope_of_work.customer.name)
      expect(page).to have_selector('iframe')
    end
  end
end

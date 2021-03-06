require "rails_helper"
require "pry"

RSpec.describe "Expense Report Management", type: :feature do 
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @user.add_role :expense_report
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "allows a user to create an expense report" do 
      visit new_expense_report_path

      fill_in "Amount", with: 5.50
      fill_in "Vendor", with: "Test Vendor" 
      select "Other", from: "Category"
      select "Visa", from: "Payment method"
      fill_in "Note", with: "Test Note"
      fill_in "Other note", with: "Test Other Note"
      select Date.today.year, from: "expense_report_date_1i"
      select Date.today.strftime("%B"), from: "expense_report_date_2i"
      select Date.today.day, from: "expense_report_date_3i"
      attach_file "Receipt", "#{Rails.root}/spec/support/fixtures/test_pic.jpg"
      expect {
        click_on "Create Expense report"
      }.to change(ExpenseReport, :count).by(1)

      @expense_report = ExpenseReport.first

      expect(page).to have_current_path(expense_report_path(@expense_report))
      expect(page).to have_content(@user.full_name)
      expect(page).to have_content(@expense_report.amount)
      expect(page).to have_content(@expense_report.vendor)
      expect(page).to have_content(@expense_report.note)
      expect(page).to have_content(@expense_report.other_note)
      expect(page).to have_content(@expense_report.category.humanize)
      expect(page).to have_content(@expense_report.payment_method.humanize)
    end
  end
end

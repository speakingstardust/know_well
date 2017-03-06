require "pry"
Given(/^a user that is either an Admin or has the bookkeeper role\.$/) do
  @user = User.create(first_name: "Test", last_name: "Testing", email: "test@testing.com", password: "password", password_confirmation: "password")
  @user.add_role :bookkeeper
  visit '/users/sign_in'
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_button "Log in"
end

Given(/^a customer\.$/) do
  @customer = Customer.create(name: "Test Customer")
end

Given(/^jigs that belong to the customer\.$/) do
  @jig = Jig.create(name: "Test Jig", customer: @customer)
end

When(/^I visit the work order management page\.$/) do
  visit '/work_orders_management'
end

When(/^I select the customer from the dropdown\.$/) do
  select 'Test Customer', from: 'customer_customer_id'
end

When(/^I click Jig Work Order\.$/) do
  click_link('Jig Work Order')
end

Then(/^I am on the new jig work order details page\.$/) do
  expect(page).to have_current_path(new_jig_work_order_path)
end

Then(/^I am able to set a pickup date and time\.$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I am able to add the expected number of jigs to the work order\.$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I submit the new work order\.$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I am on the work order index page\.$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the new work order is present on the work order index page\.$/) do
    pending # Write code here that turns the phrase above into concrete actions
end


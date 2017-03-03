Given(/^a user that is either an Admin or has the bookkeeper role\.$/) do
  @user = User.create(first_name: "Test", last_name: "Testing", email: "test@example.com")
  @user.add_role :bookkeeper
end

Given(/^a customer\.$/) do
  @customer = Customer.create(name: "Test Customer")
end

Given(/^jigs that belong to the customer\.$/) do
  @first_jig = Jig.create(name: "Jig One", customer: @customer)
  @second_jig = Jig.create(name: "Jig Two", customer: @customer) 
end

When(/^I visit the new work order page\.$/) do
  visit '/work_orders/new'
end

When(/^I complete the initial work order form, choosing the type of work order and a customer\.$/) do
  select 'Jig', from: 'Type'
  select 'Test Customer', from: 'Customer'
end

Then(/^I am on the jig work order details page\.$/) do
  expect(page).to have_current_path(new_jig_work_orders_path)
end

Then(/^I am able to set a pickup date and time\.$/) do
  select "#{Date.today.day}", from: 'Date'
  select "#{Date.today.month}", from: 'Month'
  select "#{Date.today.year}", from: 'Year'
  select "#{Time.now}", from: 'Time'
end

Then(/^I am able to add the expected number of jigs to the work order\.$/) do
  select 'Jig One', from: 'Jig'
  fill_in 'Expected', with: '10'
  click_button 'Add Jig'
end

Then(/^I submit the new work order\.$/) do
  click_button 'Submit'
end

Then(/^I am on the work order index page\.$/) do
  expect(page).to have_current_path(work_orders_path)
end

Then(/^the new work order is present on the work order index page\.$/) do
  expect(page).to have_content("Test Company")
  expect(page).to have_content(Date.today)
end

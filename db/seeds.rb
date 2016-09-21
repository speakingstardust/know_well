# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


3.times do |n|
	name = Faker::Company.name
	phone = Faker::PhoneNumber.phone_number
	fax = Faker::PhoneNumber.phone_number
	st_address = Faker::Address.street_address
	city = Faker::Address.city
	state = Faker::Address.state
	zip = Faker::Address.zip
	Customer.create!(name: name, phone: phone, fax: fax, street_address: st_address, city: city, state: state, zip: zip)
end

25.times do |n|
	name = Faker::Lorem.word
	customer = Customer.first.id
	charge = 12
	Jig.create!(name: name, customer_id: customer, cleaning_charge: charge, repair_charge: charge)
end

25.times do |n|
	name = Faker::Lorem.word
	customer = Customer.last.id
	charge = 12
	Jig.create!(name: name, customer_id: customer, cleaning_charge: charge, repair_charge: charge)
end

50.times do |n| 
	customer_id = Customer.order("RANDOM()").first.id
	date = Faker::Date.forward(n)

	order = JigOrder.create!(customer_id: customer_id, date: date)

	line_item = nil

	3.times do |j|
		jig_id = Jig.order("RANDOM()").first.id
		cleaned = Faker::Number.number(3)
		repaired = Faker::Number.number(2)

		line_item = JigOrderLineItem.create!(jig_id: jig_id, repaired: repaired, cleaned: cleaned, jig_order_id: order.id)
	end

	order.jig_order_line_item_id = line_item.id
end


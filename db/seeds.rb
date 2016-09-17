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

5.times do |n| 
	
end


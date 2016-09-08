# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
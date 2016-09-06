# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
25.times do |n|
	name = 5 + rand(10)
	charge = 12
	Jig.create!(name: name, cleaning_charge: charge, repair_charge: charge)
end
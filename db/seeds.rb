# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
place1 = Place.create(name: "Pune", country: "India")
place2 = Place.create(name: "Melbourne", country: "Australia")
destination1 = Destination.create(category: "International", place: place1)
destination2 = Destination.create(category: "Local", place: place2)


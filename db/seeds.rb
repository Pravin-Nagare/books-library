# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file=File.open("db/isbn.csv")
content=file.read.split
content.each do |i|
	Book.create(:isbn=>i) unless i=="ISBN"
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
isbn=File.open("db/isbn.csv","r").read.split
detail=Openlibrary::Data
isbn.each do |i|
  if(i!="ISBN")
   begin
    title = detail.find_by_isbn(i).title
    Book.create :isbn=>i,:title=>title
   rescue Exception=>e
   	puts e.message
   end
   
   end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Pokemon.name, phone_number: Faker::PhoneNumber.phone_number)
end

5.times do |i|
  line = Line.new(name:Faker::University.name)
  User.all.sample.created_lines << line
end

15.times do |i|
  begin
  Line.all.sample.users << User.all.sample
rescue => e
  end
end

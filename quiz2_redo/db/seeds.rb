# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

choices = ["marketing", "sales", "technical"]
1000.times do
  support_request = SupportRequest.new( name: Faker::Name.name,
                                email: Faker::Internet.email,
                                department: choices.sample,
                                message: Faker::Hacker.say_something_smart)
  support_request.save
end

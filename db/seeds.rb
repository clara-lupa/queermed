# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Provider.destroy_all
User.destroy_all
Review.destroy_all

PASSWORD = "123456"
USERS = %w[igor dan magda clara]
SPECIALTIES = %w[Psychotherapist Gynecologist Dermatologist Physiotherapist Dentist]


puts "creating 4 users"

USERS.each do |user|
  User.create(
    nickname: user,
    email: "#{user}@test.org",
    password: PASSWORD
    )
end

puts "creating 10 providers"

10.times do
  Provider.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: "Dr.",
    homepage: Faker::Internet.url,
    phone_number: "030/12345678",
    specialty: SPECIALTIES.sample,
    address: "Berlin"
    )
end

puts "creating 30 reviews"
30.times do
  Review.create!(
    content: Faker::Quote.famous_last_words,
    user: User.all.sample,
    provider: Provider.all.sample
    )
end
puts "finished"


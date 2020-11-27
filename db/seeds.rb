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
SPECIALTIES = %w[Psychotherapist Psychotherapist Psychotherapist Psychologist Psychologist Psychologist Gynecologist Dermatologist Physiotherapist Dentist]
ADDRESS = ["Anzengruberstr. 10, 12043 Berlin", "Kienitzerstr. 101, 12053 Berlin", "Sonnenallee 101, 12045 Berlin", "Rudi-Dutschke-Str. 26, 10969 Berlin"]
AVATAR_BASE_PATH = "avatar/avatar_0"
AVATAR_SUFFIX = ".svg"

puts "creating 20 random users"

20.times do
  name = Faker::Name.first_name
  User.create(
    nickname: name,
    email: "#{name}@test.org",
    password: PASSWORD,
    avatar: AVATAR_BASE_PATH + (rand(6) + 1).to_s + AVATAR_SUFFIX
    )
end

puts "creating 10 providers with 0-5 recommendations"

10.times do
  provider = Provider.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: "Dr.",
    homepage: Faker::Internet.url,
    phone_number: "030/12345678",
    specialty: SPECIALTIES.sample,
    address: ADDRESS.sample,
    )
  number_of_recs = rand(6)
  recommenders = User.all.sample(number_of_recs)
  recommenders.each do |rec|
    Review.create!(user: rec, provider: provider)
  end
end

puts "creating 4 active users"

USERS.each do |user|
  User.create(
    nickname: user,
    email: "#{user}@test.org",
    password: PASSWORD,
    avatar: AVATAR_BASE_PATH + (rand(6) + 1).to_s + AVATAR_SUFFIX
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




# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Conversation.destroy_all
Message.destroy_all
Shortlist.destroy_all
Review.destroy_all
Provider.destroy_all
User.destroy_all


PASSWORD = "123456"
USERS = %w[igor dan magda clara ]
SPECIALTIES = %w[Psychotherapist Psychotherapist Psychotherapist Psychologist Psychologist Psychologist Dermatologist Physiotherapist Dentist]
ADDRESS = [ "Rudi-Dutschke-Str. 26, 10969 Berlin", "Sonnenallee 101, 12045 Berlin","Anzengruberstr. 10, 12043 Berlin", "Kienitzerstr. 101, 12053 Berlin", "Turmstr. 28, Berlin", "Goethestr. 33, Berlin", "Neue Hochstr. 14, Berlin", "Potsdamer Str. 55, Berlin", "Tempelhofer Damm 51, Berlin", "Sebastianstr. 14, Berlin", "Wildenbruchstr. 10, Berlin", "Selchower Str. 12, Berlin"]
AVATAR_BASE_PATH = "avatar/avatar_0"
AVATAR_SUFFIX = ".svg"


puts "Creating 20 random users"

20.times do
  name = Faker::Name.first_name
  User.create(
    nickname: name,
    email: "#{name}@test.org",
    password: PASSWORD,
    avatar: AVATAR_BASE_PATH + (rand(6) + 1).to_s + AVATAR_SUFFIX
    )
end


reviews = []
reviews << [
  "I come to Dr. Barris for my regular check-ups for many years and I was always treated well.",
  "She really explained every step to me in detail, I liked that a lot.",
  "Overall a good experience. I was really happy that they called me with the correct pronoun.
  Not many other gynecologists do that from my experiences...",
    "", "", ""
]


reviews << [
  "I came here a couple of times to get prescriptions and check-ups. Dr. Carter seems to be very empathic, she took more than enough time for me and I felt quite comfortable with her.",
  "I went to Dr. Carter to talk about my wish to have a baby with my girlfriend. She was really well informed, told me a lot about our different options and I never felt judged by her during the whole process.", "", "", ""
]

reviews << [
  "I went to Dr. Collins when I got pregnant and kept going there during my whole pregnancy. I found him very competent and friendly."
]

reviews << [""]

puts "creating 4 demo providers"

first_names = ['Kim', 'Susan', 'Jo', 'Michael']
last_names = ['Barris', 'Carter', 'Collins', 'Goldner']
4.times do |i|
  prov = Provider.create!(
      first_name: first_names[i],
      last_name: last_names[i],
      title: "Dr.",
      homepage: Faker::Internet.url,
      phone_number: "030/#{rand(10000000..99999999)}",
      specialty: "Gynecologist",
      address: ADDRESS[i]
    )
  reviewers = User.all.sample(reviews[i].length)

  reviews[i].each_with_index do |content, index|
    Review.create!(
      provider: prov,
      user: reviewers[index],
      content: content
      )
  end
end


puts "creating demo user"

User.create!(
  nickname: "Jessi89",
  email: "jessi.xyz@riseup.net",
  password: PASSWORD,
  avatar: "avatar/avatar_07.svg"
  )

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


# puts "creating 30 reviews"
# 30.times do
#   Review.create!(
#     content: Faker::Quote.famous_last_words,
#     user: User.all.sample,
#     provider: Provider.all.sample
#     )
# end
puts "finished"




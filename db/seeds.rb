# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

start_date = Date.today - 365
end_date = Date.today - 1
random_date = rand(start_date..end_date)

puts"Cleaning db"

Moodtracker.destroy_all
SuggestionsComment.destroy_all
Suggestion.destroy_all
Event.destroy_all
Question.destroy_all
User.destroy_all


puts"creating users"

sales1 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Sales",
  password: "secret"
)
sales2 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Sales",
  password: "secret"
)
sales3 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Sales",
  password: "secret"
)
sales4 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Sales",
  password: "secret"
)

marketing1 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Marketing",
  password: "secret"
)
marketing2 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Marketing",
  password: "secret"
)

marketing3 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Marketing",
  password: "secret"
)
marketing4 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  job_position: Faker::Job.position,
  location: Faker::Address.country,
  team: "Marketing",
  password: "secret"
)

admin1 = User.create!(
  first_name: "Bruno",
  last_name: "Bond",
  email: "admin1@glowork.com",
  admin: true,
  job_position: "Sales Manager",
  team: "Sales",
  location: Faker::Address.country,
  password: "secret"
)
admin2 = User.create!(
  first_name: "Mimi",
  last_name: "James",
  email: "admin2@glowork.com",
  admin: true,
  job_position: "Marketing Manager",
  team: "Marketing",
  location: Faker::Address.country,
  password: "secret"
)

user = User.create!(
  first_name: "Jane",
  last_name: "Smith",
  email: "user@glowork.com",
  admin: false,
  job_position: "Employee",
  team: "Sales",
  location: Faker::Address.country,
  password: "secret"
)

puts "#{User.count} users created"
puts"creating moodtrackers"

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: user
  )
end

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: admin2
  )
end

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: admin1
  )
end

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: sales1
  )
end
100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: sales2
  )
end

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: marketing1
  )
end

100.times do
  Moodtracker.create!(
    mood: (1..3).to_a.sample,
    date: rand(start_date..end_date),
    user: marketing2
  )
end

puts "#{Moodtracker.count} moodtracker created"
puts "creating suggestions"

suggestion1 = Suggestion.create!(
  suggestion: Faker::Lorem.sentence,
  date: rand(start_date..end_date),
  actioned: false
)
suggestion2 = Suggestion.create!(
  suggestion: Faker::Lorem.sentence,
  date: rand(start_date..end_date),
  actioned: false
)
suggestion3 = Suggestion.create!(
  suggestion: Faker::Lorem.sentence,
  date: rand(start_date..end_date),
  actioned: false
)
puts "#{Suggestion.count} suggestions created"
puts "creating comments"

comment1 = SuggestionsComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales1,
  suggestion: suggestion1
)
comment2 = SuggestionsComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales2,
  suggestion: suggestion1
)
comment3 = SuggestionsComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales3,
  suggestion: suggestion2
)
comment4 = SuggestionsComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales1,
  suggestion: suggestion3
)
puts "#{SuggestionsComment.count} suggestions_comments created"

puts "Creating Events..."

Event.create!(event_name: "End of bootcamp party", start_date: "25/06/2025 19:00", end_date: "25/05/2025 22:00", location: "London", user: admin1)
Event.create!(event_name: "Catch-up Meeting", start_date: "24/06/2025 09:00", end_date: "24/05/2025 10:00", location: "Liverpool", user: admin1)
Event.create!(event_name: "Summer Meeting", start_date: "23/06/2025 17:00", end_date: "23/05/2025 19:00", location: "Manchester", user: admin1)

puts "#{Event.count} events created"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

start_date = Date.today - 7
end_date = Date.today - 1
random_date = rand(start_date..end_date)

puts"Cleaning db"

Moodtracker.destroy_all
SuggestionComment.destroy_all
Suggestion.destroy_all
User.destroy_all

puts"creating users"

salesmanager = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  admin: true,
  job_position: "Sales Manager",
  team: "Sales",
  location: Faker::Address.country,
  password: "secret"
)
marketingmanager = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  admin: true,
  job_position: "Marketing Manager",
  team: "Marketing",
  location: Faker::Address.country,
  password: "secret"
)

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

admin = User.create!(
  first_name: "Admin",
  last_name: "Adminson",
  email: "admin@glowork.com",
  admin: true,
  job_position: "Bossman",
  team: "All",
  location: Faker::Address.country,
  password: "secret"
)

user = User.create!(
  first_name: "User",
  last_name: "Userson",
  email: "user@glowork.com",
  admin: true,
  job_position: "Employee",
  team: "Sales",
  location: Faker::Address.country,
  password: "secret"
)

puts "#{User.count} users created"
puts"creating moodtrackers"

Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales2
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales2
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: sales2
)

Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing1
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing2
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing2
)
Moodtracker.create!(
  mood: (1..3).to_a.sample,
  date: rand(start_date..end_date),
  user: marketing2
)
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

comment1 = SuggestionComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales1,
  suggestion: suggestion1
)
comment2 = SuggestionComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales2,
  suggestion: suggestion1
)
comment3 = SuggestionComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales3,
  suggestion: suggestion2
)
comment4 = SuggestionComment.create!(
  comment: Faker::Lorem.sentence,
  user: sales1,
  suggestion: suggestion3
)
puts "#{SuggestionComment.count} suggestions_comments created"

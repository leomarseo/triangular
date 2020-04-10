# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating 100 users...'
50.times do |i|
  user = User.create!(
    first_name: Faker::Games::Dota.hero,
    last_name: Faker::Games::HeroesOfTheStorm.hero,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  puts "#{i + 1}. #{user.first_name} #{user.last_name}"
end
50.times do |i|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  puts "#{i + 1}. #{user.first_name} #{user.last_name}"
end
# create a MASKS seed
#

puts 'Finished!'
# dadadada

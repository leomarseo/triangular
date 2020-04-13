# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create a USERS seed
#
puts 'Creating 100 users...'
10.times do |i|
  user = User.create!(
    first_name: Faker::Games::Dota.hero,
    last_name: Faker::Games::HeroesOfTheStorm.hero,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  puts "#{i + 1}. #{user.first_name} #{user.last_name}"
end
10.times do |i|
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
# users = User.all
array_size = ['Child', 'Adult', 'Hagrid']
condition = ['used', 'new']
20.times do |i|
  mask = Mask.create!(
    user: User.all.sample,
    description: Faker::Books::Dune.saying,
    condition: condition.sample,
    size: array_size.sample
    # email: Faker::Internet.email,
    # password: Faker::Internet.password
  )
  # puts "#{i + 1}. #{user.first_name} #{user.last_name}"
end

# create a RESERVATIONS seed
# create two separate groups of user: one for owners, another for renters
# user.find / user.where /user.include?
is_active = ['true', 'false']
user_owner = User.all[0..9]
user_renter = User.all[10..20]
all_masks = Mask.all
# booked_mask = Mask.all.where("user_id: #{}")
10.times do |i|
  reservation = Reservation.create!(
    user_id: user_renter.sample,
    mask_id: all_masks.include?(user_owner.mask_id),
    start_time: Faker::Date.between(from: 15.days.ago, to: Date.today),
    end_time: Faker::Date.forward(days: 30),
    active: is_active.sample
  )
end
# create a REVIEWS seed
#

puts 'Finished!'


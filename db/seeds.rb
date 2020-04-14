# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create a USERS seed
#
puts 'Creating some users...'
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
30.times do |i|
  mask = Mask.create!(
    name: Faker::DcComics.name,
    user: User.all.sample,
    description: Faker::Books::Dune.saying,
    condition: condition.sample,
    size: array_size.sample,
    start_time: Faker::Date.between(from: 15.days.ago, to: Date.today),
    end_time: Faker::Date.forward(days: 30)
    # email: Faker::Internet.email,
    # password: Faker::Internet.password
  )
end
  puts "Created #{Mask.all.count} masks!"

# create a RESERVATIONS seed
# create two separate groups of user: one for owners, another for renters
# user.find / user.where
# is_active = ['true', 'false']
def random_owner
  Mask.all.sample.id
end

user_renter = User.all[11..20]
all_masks = Mask.all
all_masks_uid = []
# booked_mask = Mask.all.where("user_id: #{}")
10.times do |i|
  reservation = Reservation.create!(
    user_id: user_renter.sample.id,
    # mask_id: all_masks.include?(user_owner.mask_id),
    # mask_id: all_masks.each do |key, value|
    #   all_masks_uid << all_masks[key].user_id.to_i
    # end
    # ,
    # mask_id: all_masks.each_key do |key|
    #   all_masks_uid << all_masks[key].user_id.to_i
    # end,
    # mask_id: Mask.joins(:user).where({user: user_owner.sample}),
    # mask_id: user_owner.sample.masks.sample.id,
    mask_id: random_owner,
    start_time: Faker::Date.between(from: 15.days.ago, to: Date.today),
    end_time: Faker::Date.forward(days: 30),
    confirmed: [true, true, false].sample
  )
end
  puts "Created #{Reservation.all.count} reservations!"
# create a REVIEWS seed
#
# Review.create(content: "test", rating: 1, reviewable_id: Mask.all.sample.id)

20.times do |i|
  reviews = Review.create!(
    content: Faker::Books::Lovecraft.paragraph,
    rating: [0, 1].sample,
    # reviewable_type: "Mask",
    # reviewable_id: Mask.all.sample.id
    reviewable: Mask.all.sample
  )
end

20.times do |i|
  reviews = Review.create!(
    content: Faker::Books::Lovecraft.paragraph,
    rating: [0, 1].sample,
    # reviewable_type: "Mask",
    # reviewable_id: Mask.all.sample.id
    reviewable: Reservation.all.sample
  )
end
  puts "Created #{Review.all.count} reviews!"

# something here
puts 'Finished!'
# to-do: add a put after each seeds is completed
#
#
#
#

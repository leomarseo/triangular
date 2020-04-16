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

real_addresses = ['242 E Fern Ave., Redlands, CA, 92373',
                  '937 Fulbright Ave., Redlands, CA, 92373',
                  'Franzoesische Allee 30, 72072 Tuebingen, DE',
                  'Strada Cicero Nr. 30 Ploiesti, Prahova, RO',
                  'Hafengasse 11, 72072 Tuebingen, DE',
                  'Bohnenberger strasse 20, 72072 Tuebingen, DE',
                  'Rua Coronel Feijó 1129, Higienópolis, Porto Alegre - Rio Grande do Sul, 90340, Brazil',
                  'Via Mario Morgantini 14, Milano, Italia',
                  'Rua Luzitana, 182, Porto Alegre, Brazil',
                  '2036 University Ave, Berkeley, California 94704, United States of America',
                  '2530 Durant Ave, Berkeley, California 94704, United States of America',
                  '1328 6th St, Berkeley, California 94710, United States of America',
                  '1265 University Ave, Berkeley, California 94702, United States of America',
                  '1901 Ashby Ave, Berkeley, California 94703, United States of America',
                  '3084 Claremont Ave, Berkeley, California 94705, United States of America',
                  'University of California, Berkeley, CA, Berkeley, California 94720, United States of America',
                  '830 Regal Rd, Berkeley, California 94708, United States of America',
                  'Great Stoneface Path, Berkeley, California 94707, United States of America',
                  '1002 Solano Ave, Albany, California 94706, United States of America',
                  'Ocean View Park, Albany, California 94706, United States of America'
                  ]
# the first 10 users are created using real addresses so that geocode works properly
20.times do |i|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: real_addresses[i],
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  puts "#{i + 1}. #{user.first_name} #{user.last_name}"
end
# 10.times do |i|
#   user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     address: real_addresses[i + 9],
#     email: Faker::Internet.email,
#     password: Faker::Internet.password
#   )
#   puts "#{i + 1}. #{user.first_name} #{user.last_name}"
# end
# 10.times do |i|
#   user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     address: real_addresses.sample,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password
#   )
#   puts "#{i + 1}. #{user.first_name} #{user.last_name}"
# enduser_renter = User.all[11..20]

# 10.times do |i|
#   user = User.create!(
#     first_name: Faker::Games::Dota.hero,
#     last_name: Faker::Games::HeroesOfTheStorm.hero,
#     address: Faker::Address.full_address,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password
#   )
#   puts "#{i + 1}. #{user.first_name} #{user.last_name}"
# end
# 10.times do |i|
#   user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     address: Faker::Address.full_address,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password
#   )
#   puts "#{i + 1}. #{user.first_name} #{user.last_name}"
# end
# create a MASKS seed

users = User.all
user_owner = User.all[0..20]
array_size = ['Child', 'Adult', 'Hagrid']
condition = ['used', 'new']

owner_counter = 1
20.times do |i|
  mask = Mask.create!(
    name: Faker::GreekPhilosophers.name,
    user: user_owner.sample,
    description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 4),
    condition: condition.sample,
    size: array_size.sample,
    start_time: Faker::Date.between(from: 15.days.ago, to: Date.today),
    end_time: Faker::Date.forward(days: 30),
    price: rand(20).to_f
  )
  mask.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'masks', "mask_#{owner_counter}.jpg")),
        filename: "mask_#{owner_counter}.jpg", content_type: 'image/jpg')
  mask.save
  owner_counter += 1
end
  puts "Created #{Mask.all.count} masks!"

user_renter = User.all[11..20]

counter = 1

10.times do |i|
  mask = Mask.new(
    name: Faker::Artist.name,
    user: User.all.sample,
    description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 4),
    condition: condition.sample,
    size: array_size.sample,
    start_time: Faker::Date.between(from: 15.days.ago, to: Date.today),
    end_time: Faker::Date.forward(days: 30),
    price: rand(20).to_f
    # email: Faker::Internet.email,
    # password: Faker::Internet.password
  )
  mask.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'masks', "mask_#{counter}.jpg")),
        filename: "mask_#{counter}.jpg", content_type: 'image/jpg')
  mask.save
  counter += 1
end
  puts "Created #{Mask.all.count} masks!"

# create a RESERVATIONS seed
# create two separate groups of user: one for owners, another for renters
# user.find / user.where
# is_active = ['true', 'false']
def random_owner
  Mask.all.sample.id
end

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
    content: Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 4),
    rating: [0, 1].sample,
    # reviewable_type: "Mask",
    # reviewable_id: Mask.all.sample.id
    reviewable: Mask.all.sample,
    user_id: User.all.sample.id
  )
end

20.times do |i|
  reviews = Review.create!(
    content: Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 4),
    rating: [0, 1].sample,
    # reviewable_type: "Mask",
    # reviewable_id: Mask.all.sample.id
    reviewable: Reservation.all.sample,
    user_id: User.all.sample.id
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

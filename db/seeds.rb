# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def user_params(user_name, user_gender)
  date = Faker::Time.between(from: 1.year.ago, to: Time.zone.now)

  {
    username: Faker::Internet.unique.username(specifier: 5..10),
    email: Faker::Internet.unique.email,
    password: "password",
    name: user_name,
    gender: user_gender,
    location: Faker::Address.city,
    created_at: date,
    updated_at: date
  }
end

def content(num)
  case num
  when 0..36
    Faker::JapaneseMedia::OnePiece.quote
  when 37..72
    Faker::JapaneseMedia::StudioGhibli.quote
  when 73..108
    Faker::JapaneseMedia::CowboyBebop.quote
  when 109..144
    Faker::Games::Witcher.quote
  else
    Faker::Games::Fallout.quote
  end
end

users = []
sample_user = User.create(
  username: "sampleuser",
  email: "sample@user.com",
  password: "password",
  name: "Sample User",
  gender: "male",
  location: "Sample City",
  created_at: Faker::Time.between(from: 1.year.ago, to: Time.zone.now)
)
users << sample_user

50.times do |i|
  first_name = i <= 23 ? Faker::Name.female_first_name : Faker::Name.male_first_name
  name = "#{first_name} #{Faker::Name.last_name}"
  gender = i <= 23 ? "female" : "male"

  users << User.create(user_params(name, gender))

  puts "User#{i + 1} created!"
end

users.each do |user|
  rand(users.length).times do |i|
    Friend.create(
      user_id: user.id,
      friend_id: users[rand(users.length)].id
    )

    puts "Friend#{i + 1} created!"
  end
end

posts = []
180.times do |i|
  user = users[rand(users.length)]
  date = Faker::Time.between(from: user.created_at, to: Time.zone.now)

  posts << Post.create(
    user_id: user.id,
    content: content(i),
    created_at: date,
    updated_at: date
  )

  puts "Post#{i + 1} created!"
end

posts.each do |post|
  rand(10).times do |i|
    date = Faker::Time.between(from: post.created_at, to: Time.zone.now)
    Comment.create(
      user_id: users[rand(users.length)].id,
      post_id: post.id,
      content: Faker::Quote.famous_last_words,
      created_at: date,
      updated_at: date
    )

    puts "Comment#{i + 1} created!"
  end

  rand(20).times do |i|
    Like.create(
      user_id: users[rand(users.length)].id,
      post_id: post.id
    )

    puts "Like#{i + 1} created!"
  end
end

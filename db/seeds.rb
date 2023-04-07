# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Notification.delete_all
Friend.delete_all
Comment.delete_all
Like.delete_all
Post.delete_all
User.delete_all

def user_params(user_name, user_gender)
  {
    username: Faker::Internet.unique.username(specifier: 5..10),
    email: Faker::Internet.unique.email,
    password: "password",
    name: user_name,
    gender: user_gender,
    location: Faker::Address.city
  }
end

50.times do |i|
  first_name = i <= 23 ? Faker::Name.female_first_name : Faker::Name.male_first_name
  name = "#{first_name} #{Faker::Name.last_name}"
  gender = i <= 23 ? "female" : "male"

  User.create!(user_params(name, gender))

  puts "User#{i} created!"
end

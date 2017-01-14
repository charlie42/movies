# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :email => '1@1.1', :password => '111111', :password_confirmation => '111111'
puts 'New user created: ' << user.email
user2 = User.create! :email => '2@2.2', :password => '222222', :password_confirmation => '222222'
puts 'New user created: ' << user2.email

puts 'movies'
movie = Movie.create! :name => 'first movie', :rating => 20
movie1 = Movie.create! :name => 'second movie', :rating => 100

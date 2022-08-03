# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(username: 'admin', password: 'pass1', password_confirmation: 'pass1', bio: 'I am the admin', image_url: 'http://www.gravatar.com/')
recipe = Recipe.create(title: "Pizza", instructions: "Pizza is a savory dish of Italian origin, consisting of a usually round, flattened base of leavened wheat-based dough topped with tomatoes, cheese, and various other ingredients.", minutes_to_complete:20)
user.recipes << recipe

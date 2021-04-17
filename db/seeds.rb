# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

netflix = Service.create(
  name: 'Netflix',
  watchmode_id: 203,
  logo: 'netflix_logo.png'
)

amazon_prime = Service.create(
  name: 'Amazon Prime Video',
  watchmode_id: 26,
  logo: 'prime_video_logo.jpeg'
)

hulu = Service.create(
  name: 'Hulu',
  watchmode_id: 157,
  logo: 'hulu_logo.jpeg'
)

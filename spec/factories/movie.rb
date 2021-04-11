FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    tmdbid { Faker::Number.within(range: 1..100000) }
    poster_path { Faker::LoremFlickr.image }
    description { Faker::Movie.quote }
    genres { Faker::Book.genre }
    vote_average { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    vote_count { Faker::Number.within(range: 1..10000) }
    year { Faker::Number.within(range: 1920..2021) }
  end
end

FactoryBot.define do
  factory :service do
    name { Faker::Music::GratefulDead.song }
    watchmode_id { Faker::Number.within(range: 1..1000) }
    logo { Faker::LoremFlickr.image }
  end
end

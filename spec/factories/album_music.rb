FactoryBot.define do
  factory :album_music do
    association :creater
    association :listener
    association :album
    name { Faker::Name.name }
    caption { Faker::Lorem.characters(number: 50) }
    music_url { Faker::Lorem.characters(number: 30) }
  end
end

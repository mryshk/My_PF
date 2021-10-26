FactoryBot.define do
  factory :album do
    association :creater
    name { Faker::Name.name }
    caption { Faker::Lorem.characters(number: 30) }
    album_url { Faker::Lorem.characters(number: 10) }
    album_image_id { Faker::Lorem.characters(number: 10) }
    genre { Faker::Number.between(from: 0, to: 7) }
  end
end

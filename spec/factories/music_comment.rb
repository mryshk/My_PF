FactoryBot.define do
  factory :music_comment do
    association :listener
    association :album
    association :album_music
    comment { Faker::Lorem.characters(number: 50) }
    rate { Faker::Number.between(from: 0.0, to: 5.0) }
  end
end

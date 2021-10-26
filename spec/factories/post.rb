FactoryBot.define do
  factory :post do
    association :listener
    post_tweet { Faker::Lorem.characters(number: 30) }
    post_url { Faker::Lorem.characters(number: 10) }
    picture_id { Faker::Lorem.characters(number: 10) }
    post_genre { Faker::Number.between(from: 0, to: 7) }
    impressions_count { Faker::Number.number }
  end
end

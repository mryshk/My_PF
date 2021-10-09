FactoryBot.define do
  factory :post do
    association :listener
    post_tweet { Faker::Lorem.characters(number:30) }
    post_url { Faker::Lorem.characters(number:10) }
    picture_id { Faker::Lorem.characters(number:10) }
  end

end
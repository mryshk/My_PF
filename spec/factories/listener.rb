FactoryBot.define do
  factory :listener do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    name { Faker::Name.name }
    caption { Faker::Lorem.characters(number: 30) }
    provider { Faker::Lorem.characters(number: 10) }
    uid { Faker::Lorem.characters(number: 10) }
    profile_image_id { Faker::Lorem.characters(number: 10) }
    impressions_count {Faker::Number.number}
    listener_type { Faker::Number.between(from: 0, to: 1)}
  end
end

FactoryBot.define do
  factory :listener do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:10) }
    name { Faker::Name.name }
    caption { Faker::Lorem.characters(number:30) }
    provider { Faker::Lorem.characters(number:10) }
    uid { Faker::Lorem.characters(number:10) }
    profile_image_id { Faker::Lorem.characters(number:10) }
  end

end